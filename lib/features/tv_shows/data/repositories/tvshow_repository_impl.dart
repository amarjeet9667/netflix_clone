// lib/features/tv_shows/data/repositories/tvshow_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/series_entity.dart';
import '../../domain/entities/season_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/repositories/tvshow_repository.dart';
import '../datasources/tvshow_remote_datasource.dart';

class TVShowRepositoryImpl implements TVShowRepository {
  final TVShowRemoteDataSource remoteDataSource;
  final NetworkInfo            networkInfo;

  const TVShowRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SeriesEntity>>> getTVShows() async {
    try {
      final shows = await remoteDataSource.getTVShows();
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeriesEntity>> getShowDetail(int showId) async {
    try {
      final show = await remoteDataSource.getShowDetail(showId);
      return Right(show);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeriesEntity>>> getTrendingShows() async {
    try {
      final shows = await remoteDataSource.getTrendingShows();
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeriesEntity>>> getNetflixOriginals() async {
    try {
      final shows = await remoteDataSource.getNetflixOriginals();
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeriesEntity>>> getShowsByGenre(
      String genre) async {
    try {
      final shows = await remoteDataSource.getShowsByGenre(genre);
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeriesEntity>>> getSimilarShows(
      int showId) async {
    try {
      final shows = await remoteDataSource.getSimilarShows(showId);
      return Right(shows);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SeasonEntity>>> getSeasons(int showId) async {
    try {
      final seasons = await remoteDataSource.getSeasons(showId);
      return Right(seasons);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodes({
    required int showId,
    required int seasonNumber,
  }) async {
    try {
      final episodes = await remoteDataSource.getEpisodes(
        showId: showId,
        seasonNumber: seasonNumber,
      );
      return Right(episodes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EpisodeEntity>> getEpisodeDetail({
    required int showId,
    required int seasonNumber,
    required int episodeNumber,
  }) async {
    try {
      final episode = await remoteDataSource.getEpisodeDetail(
        showId:        showId,
        seasonNumber:  seasonNumber,
        episodeNumber: episodeNumber,
      );
      return Right(episode);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}