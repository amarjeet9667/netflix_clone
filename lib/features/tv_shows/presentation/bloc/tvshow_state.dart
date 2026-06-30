// lib/features/tv_shows/presentation/bloc/tvshow_state.dart
part of 'tvshow_bloc.dart';

abstract class TVShowState extends Equatable {
  const TVShowState();
  @override
  List<Object?> get props => [];
}

class TVShowInitial extends TVShowState {
  const TVShowInitial();
}

class TVShowLoading extends TVShowState {
  const TVShowLoading();
}

class TVShowListLoaded extends TVShowState {
  final List<SeriesEntity> shows;
  const TVShowListLoaded({required this.shows});
  @override
  List<Object?> get props => [shows];
}

class TVShowDetailLoaded extends TVShowState {
  final SeriesEntity show;
  final List<EpisodeEntity> episodes;
  final int selectedSeason;
  const TVShowDetailLoaded({
    required this.show,
    required this.episodes,
    this.selectedSeason = 1,
  });
  @override
  List<Object?> get props => [show, episodes, selectedSeason];
}

class TVShowError extends TVShowState {
  final String message;
  const TVShowError({required this.message});
  @override
  List<Object?> get props => [message];
}
