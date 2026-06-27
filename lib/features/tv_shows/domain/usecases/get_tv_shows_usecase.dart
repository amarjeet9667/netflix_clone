import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/tvshow_entity.dart';
import '../repositories/tvshow_repository.dart';

class GetTVShowsUseCase {
  final TVShowRepository repository;
  const GetTVShowsUseCase(this.repository);

  Future<Either<Failure, List<TVShowEntity>>> call() {
    return repository.getTVShows();
  }
}
