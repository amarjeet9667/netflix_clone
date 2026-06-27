import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetSimilarMoviesUseCase {
  final MovieRepository repository;
  const GetSimilarMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call(int movieId) {
    return repository.getSimilarMovies(movieId);
  }
}
