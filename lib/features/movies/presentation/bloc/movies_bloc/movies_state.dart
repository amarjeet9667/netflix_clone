part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;
  const MoviesLoaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class MovieDetailLoaded extends MoviesState {
  final MovieEntity movie;
  final List<MovieEntity> similarMovies;

  const MovieDetailLoaded({required this.movie, required this.similarMovies});

  @override
  List<Object?> get props => [movie, similarMovies];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);
  @override
  List<Object?> get props => [message];
}
