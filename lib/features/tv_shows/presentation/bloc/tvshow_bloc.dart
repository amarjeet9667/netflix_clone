import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import '../../domain/entities/tvshow_entity.dart';
import '../../domain/entities/season_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/usecases/get_tv_shows_usecase.dart';
import '../../domain/usecases/get_episodes_usecase.dart';

part 'tvshow_event.dart';
part 'tvshow_state.dart';

class TVShowBloc extends Bloc<TVShowEvent, TVShowState> {
  final GetTVShowsUseCase getTVShows;
  final GetEpisodesUseCase getEpisodes;

  TVShowBloc({
    required this.getTVShows,
    required this.getEpisodes,
  }) : super(TVShowInitial()) {
    on<LoadTVShowsEvent>(_onLoadTVShows);
    on<LoadTVShowDetailEvent>(_onLoadTVShowDetail);
  }

  Future<void> _onLoadTVShows(LoadTVShowsEvent event, Emitter<TVShowState> emit) async {
    emit(TVShowLoading());
    final result = await getTVShows();
    result.fold(
      (failure) => emit(TVShowError(failure.message)),
      (shows) => emit(TVShowLoaded(shows)),
    );
  }

  Future<void> _onLoadTVShowDetail(LoadTVShowDetailEvent event, Emitter<TVShowState> emit) async {
    emit(TVShowLoading());
    final episodesResult = await getEpisodes(showId: event.showId, seasonNumber: 1);

    episodesResult.fold(
      (failure) => emit(TVShowError(failure.message)),
      (episodes) {
        final mockShow = DummyTVShows.shows.firstWhere(
          (s) => s['id'] == event.showId,
          orElse: () => DummyTVShows.shows.first,
        );
        final mockSeason = DummyTVShows.seasons.firstWhere(
          (s) => s['showId'] == event.showId && s['seasonNumber'] == 1,
          orElse: () => DummyTVShows.seasons.first,
        );
        emit(TVShowDetailLoaded(
          show: TVShowEntity.fromJson(mockShow),
          seasonDetail: SeasonEntity.fromJson(mockSeason),
          episodes: episodes,
        ));
      },
    );
  }
}
