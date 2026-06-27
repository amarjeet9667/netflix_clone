import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies();
  Future<Either<Failure, MovieEntity>> getMovieDetail(int id);
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(int movieId);
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query);
}
