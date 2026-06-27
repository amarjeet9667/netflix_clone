import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/season_entity.dart';
import '../repositories/tvshow_repository.dart';

class GetSeasonDetailUseCase {
  final TVShowRepository repository;
  const GetSeasonDetailUseCase(this.repository);

  Future<Either<Failure, SeasonEntity>> call({
    required int showId,
    required int seasonNumber,
  }) {
    return repository.getSeasonDetail(showId, seasonNumber);
  }
}
