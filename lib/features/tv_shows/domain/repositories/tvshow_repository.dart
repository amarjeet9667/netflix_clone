import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/tvshow_entity.dart';
import '../entities/season_entity.dart';
import '../entities/episode_entity.dart';

abstract class TVShowRepository {
  Future<Either<Failure, List<TVShowEntity>>> getTVShows();
  Future<Either<Failure, SeasonEntity>> getSeasonDetail(int showId, int seasonNumber);
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodes(int showId, int seasonNumber);
}
