// lib/features/tv_shows/presentation/bloc/tvshow_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/tv_shows/domain/entities/series_entity.dart';
import 'package:netflix_clone/features/tv_shows/domain/entities/episode_entity.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_episodes_usecase.dart';

part 'tvshow_event.dart';
part 'tvshow_state.dart';

class TVShowBloc extends Bloc<TVShowEvent, TVShowState> {
  final GetTVShowsUseCase getTVShows;
  final GetEpisodesUseCase getEpisodes;

  TVShowBloc({required this.getTVShows, required this.getEpisodes})
    : super(const TVShowInitial()) {
    on<TVShowFetchAllEvent>(_onFetchAll);
    on<TVShowFetchDetailEvent>(_onFetchDetail);
    on<TVShowFetchEpisodesEvent>(_onFetchEpisodes);
    on<TVShowSelectSeasonEvent>(_onSelectSeason);
  }

  Future<void> _onFetchAll(
    TVShowFetchAllEvent event,
    Emitter<TVShowState> emit,
  ) async {
    emit(const TVShowLoading());
    final result = await getTVShows();
    result.fold(
      (failure) => emit(TVShowError(message: failure.message)),
      (shows) => emit(TVShowListLoaded(shows: shows)),
    );
  }

  Future<void> _onFetchDetail(
    TVShowFetchDetailEvent event,
    Emitter<TVShowState> emit,
  ) async {
    emit(const TVShowLoading());
    final showResult = await getTVShows();
    showResult.fold((failure) => emit(TVShowError(message: failure.message)), (
      shows,
    ) async {
      try {
        final show = shows.firstWhere((s) => s.id.toString() == event.showId);
        final epResult = await getEpisodes(
          EpisodesParams(showId: event.showId, seasonNumber: 1),
        );
        epResult.fold(
          (failure) => emit(TVShowDetailLoaded(show: show, episodes: [])),
          (episodes) =>
              emit(TVShowDetailLoaded(show: show, episodes: episodes)),
        );
      } catch (_) {
        emit(TVShowError(message: 'Show not found.'));
      }
    });
  }

  Future<void> _onFetchEpisodes(
    TVShowFetchEpisodesEvent event,
    Emitter<TVShowState> emit,
  ) async {
    if (state is! TVShowDetailLoaded) return;
    final current = state as TVShowDetailLoaded;
    final result = await getEpisodes(
      EpisodesParams(showId: event.showId, seasonNumber: event.seasonNumber),
    );
    result.fold(
      (_) => null,
      (episodes) => emit(
        TVShowDetailLoaded(
          show: current.show,
          episodes: episodes,
          selectedSeason: event.seasonNumber,
        ),
      ),
    );
  }

  void _onSelectSeason(
    TVShowSelectSeasonEvent event,
    Emitter<TVShowState> emit,
  ) {
    if (state is! TVShowDetailLoaded) return;
    final current = state as TVShowDetailLoaded;
    emit(
      TVShowDetailLoaded(
        show: current.show,
        episodes: current.episodes,
        selectedSeason: event.seasonNumber,
      ),
    );
    add(
      TVShowFetchEpisodesEvent(
        showId: current.show.id.toString(),
        seasonNumber: event.seasonNumber,
      ),
    );
  }
}
