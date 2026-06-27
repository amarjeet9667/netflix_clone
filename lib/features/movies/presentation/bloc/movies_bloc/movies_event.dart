part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
  @override
  List<Object?> get props => [];
}

class LoadTrendingMoviesEvent extends MoviesEvent {}

class LoadMovieDetailEvent extends MoviesEvent {
  final int movieId;
  const LoadMovieDetailEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}

class LoadSimilarMoviesEvent extends MoviesEvent {
  final int movieId;
  const LoadSimilarMoviesEvent(this.movieId);
  @override
  List<Object?> get props => [movieId];
}
