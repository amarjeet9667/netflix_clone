import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/errors/error_mapper.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/tvshow_entity.dart';
import '../../domain/entities/season_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../../domain/repositories/tvshow_repository.dart';
import '../datasources/tvshow_remote_datasource.dart';

class TVShowRepositoryImpl implements TVShowRepository {
  final TVShowRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TVShowRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TVShowEntity>>> getTVShows() async {
    try {
      final shows = await remoteDataSource.getTVShows();
      return Right(shows);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, SeasonEntity>> getSeasonDetail(int showId, int seasonNumber) async {
    try {
      final season = await remoteDataSource.getSeasonDetail(showId, seasonNumber);
      return Right(season);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<EpisodeEntity>>> getEpisodes(int showId, int seasonNumber) async {
    try {
      final episodes = await remoteDataSource.getEpisodes(showId, seasonNumber);
      return Right(episodes);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }
}
