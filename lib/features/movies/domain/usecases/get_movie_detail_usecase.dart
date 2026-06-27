import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetMovieDetailUseCase {
  final MovieRepository repository;
  const GetMovieDetailUseCase(this.repository);

  Future<Either<Failure, MovieEntity>> call(int id) {
    return repository.getMovieDetail(id);
  }
}
