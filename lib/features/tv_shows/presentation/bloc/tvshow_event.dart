part of 'tvshow_bloc.dart';

abstract class TVShowEvent extends Equatable {
  const TVShowEvent();
  @override
  List<Object?> get props => [];
}

class LoadTVShowsEvent extends TVShowEvent {}

class LoadTVShowDetailEvent extends TVShowEvent {
  final int showId;
  const LoadTVShowDetailEvent(this.showId);
  @override
  List<Object?> get props => [showId];
}
