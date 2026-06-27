import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetTrendingMoviesUseCase {
  final MovieRepository repository;
  const GetTrendingMoviesUseCase(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call() {
    return repository.getTrendingMovies();
  }
}
