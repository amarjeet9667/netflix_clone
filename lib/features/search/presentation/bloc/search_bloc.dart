// lib/features/search/presentation/bloc/search_bloc.dart
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:netflix_clone/core/constants/app_constants.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/usecases/search_content_usecase.dart';
import '../../domain/usecases/get_genre_list_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

// ── Debounce transformer ───────────────────────────────────────
// Requires `stream_transform` package (lightweight, no rxdart needed):
//   stream_transform: ^2.1.0
EventTransformer<E> _debounce<E>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchContentUseCase searchContent;
  final GetGenreListUseCase  getGenreList;

  SearchBloc({
    required this.searchContent,
    required this.getGenreList,
  }) : super(const SearchInitial()) {
    on<SearchQueryChangedEvent>(
      _onQueryChanged,
      transformer: _debounce(const Duration(milliseconds: 400)),
    );
    on<SearchFetchGenresEvent>(_onFetchGenres);
    on<SearchClearEvent>(_onClear);
  }

  Future<void> _onQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<SearchState>    emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      return add(const SearchClearEvent());
    }

    if (query.length < AppConstants.minSearchLength) {
      return emit(SearchTyping(query: query));
    }

    emit(const SearchLoading());

    final result = await searchContent(SearchParams(query: query));

    result.fold(
      (failure) => emit(SearchError(message: failure.message)),
      (results) => results.isEmpty
          ? emit(SearchEmpty(query: query))
          : emit(SearchLoaded(results: results, query: query)),
    );
  }

  Future<void> _onFetchGenres(
    SearchFetchGenresEvent event,
    Emitter<SearchState>   emit,
  ) async {
    final result = await getGenreList();
    result.fold(
      (failure) => emit(SearchError(message: failure.message)),
      (genres)  => emit(SearchGenresLoaded(genres: genres)),
    );
  }

  void _onClear(
    SearchClearEvent     event,
    Emitter<SearchState> emit,
  ) {
    final genres = state is SearchGenresLoaded
        ? (state as SearchGenresLoaded).genres
        : <GenreEntity>[];
    emit(SearchInitial(genres: genres));
  }
}