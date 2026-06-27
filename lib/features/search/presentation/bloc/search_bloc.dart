// lib/features/search/presentation/bloc/search_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/search/domain/entities/search_result_entity.dart';
import 'package:netflix_clone/features/search/domain/entities/genre_entity.dart';
import 'package:netflix_clone/features/search/domain/usecases/search_content_usecase.dart';
import 'package:netflix_clone/features/search/domain/usecases/get_genre_list_usecase.dart';
import 'package:netflix_clone/core/constants/app_constants.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchContentUseCase searchContent;
  final GetGenreListUseCase  getGenreList;

  SearchBloc({
    required this.searchContent,
    required this.getGenreList,
  }) : super(const SearchInitial()) {
    on<SearchQueryChangedEvent>(
      _onQueryChanged,
      // Debounce — only fires 400ms after user stops typing
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 400))
          .switchMap(mapper),
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

    final result = await searchContent(
      SearchParams(query: query),
    );

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