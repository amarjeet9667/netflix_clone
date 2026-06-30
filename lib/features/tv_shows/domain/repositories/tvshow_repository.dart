// lib/features/tv_shows/domain/repositories/tvshow_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/series_entity.dart';
import '../entities/season_entity.dart';
import '../entities/episode_entity.dart';

abstract class TVShowRepository {
  /// All shows (browse grid)
  Future<Either<Failure, List<SeriesEntity>>> getTVShows();

  /// Single show by ID
  Future<Either<Failure, SeriesEntity>> getShowDetail(int showId);

  /// Trending shows
  Future<Either<Failure, List<SeriesEntity>>> getTrendingShows();

  /// Netflix originals only
  Future<Either<Failure, List<SeriesEntity>>> getNetflixOriginals();

  /// Shows filtered by genre
  Future<Either<Failure, List<SeriesEntity>>> getShowsByGenre(String genre);

  /// Similar shows for "More Like This"
  Future<Either<Failure, List<SeriesEntity>>> getSimilarShows(int showId);

  /// All seasons for a show
  Future<Either<Failure, List<SeasonEntity>>> getSeasons(int showId);

  /// Episodes for a specific season
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodes({
    required int showId,
    required int seasonNumber,
  });

  /// Single episode detail
  Future<Either<Failure, EpisodeEntity>> getEpisodeDetail({
    required int showId,
    required int seasonNumber,
    required int episodeNumber,
  });
}