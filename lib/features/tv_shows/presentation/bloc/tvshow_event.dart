// lib/features/tv_shows/presentation/bloc/tvshow_event.dart
part of 'tvshow_bloc.dart';

abstract class TVShowEvent extends Equatable {
  const TVShowEvent();
  @override
  List<Object?> get props => [];
}

class TVShowFetchAllEvent extends TVShowEvent {
  const TVShowFetchAllEvent();
}

class TVShowFetchDetailEvent extends TVShowEvent {
  final String showId;
  const TVShowFetchDetailEvent({required this.showId});
  @override
  List<Object?> get props => [showId];
}

class TVShowFetchEpisodesEvent extends TVShowEvent {
  final String showId;
  final int seasonNumber;
  const TVShowFetchEpisodesEvent({
    required this.showId,
    required this.seasonNumber,
  });
  @override
  List<Object?> get props => [showId, seasonNumber];
}

class TVShowSelectSeasonEvent extends TVShowEvent {
  final int seasonNumber;
  const TVShowSelectSeasonEvent({required this.seasonNumber});
  @override
  List<Object?> get props => [seasonNumber];
}
