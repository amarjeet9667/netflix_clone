import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/episode_entity.dart';
import '../repositories/tvshow_repository.dart';

class GetEpisodesUseCase {
  final TVShowRepository repository;
  const GetEpisodesUseCase(this.repository);

  Future<Either<Failure, List<EpisodeEntity>>> call({
    required int showId,
    required int seasonNumber,
  }) {
    return repository.getEpisodes(showId, seasonNumber);
  }
}
