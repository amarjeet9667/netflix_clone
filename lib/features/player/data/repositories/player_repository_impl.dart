// lib/features/player/data/repositories/player_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/playback_entity.dart';
import '../../domain/entities/subtitle_entity.dart';
import '../../domain/entities/watch_progress_entity.dart';
import '../../domain/repositories/player_repository.dart';
import '../datasources/player_local_datasource.dart';
import '../datasources/player_remote_datasource.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDataSource remoteDataSource;
  final PlayerLocalDataSource  localDataSource;
  final NetworkInfo            networkInfo;

  const PlayerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PlaybackEntity>> getStreamUrl(
      String contentId) async {
    try {
      // Attach saved position so player can resume
      final playback  = await remoteDataSource.getStreamUrl(contentId);
      final saved     = await localDataSource.getProgress(contentId);
      if (saved != null) {
        return Right(PlaybackEntity(
          contentId:     playback.contentId,
          streamUrl:     playback.streamUrl,
          savedPosition: saved.position,
          totalDuration: saved.duration,
        ));
      }
      return Right(playback);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubtitleEntity>>> getSubtitles(
      String contentId) async {
    try {
      final subs = await remoteDataSource.getSubtitles(contentId);
      return Right(subs);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveProgress({
    required String   contentId,
    required Duration position,
    required Duration duration,
  }) async {
    try {
      final entity = WatchProgressEntity(
        contentId: contentId,
        position:  position,
        duration:  duration,
        savedAt:   DateTime.now(),
      );
      await localDataSource.saveProgress(entity);

      // Also persist remotely if online (fire-and-forget)
      final isConnected = await networkInfo.isConnected;
      if (isConnected) {
        // TODO: await apiClient.patch('/player/$contentId/progress',
        //           data: {'positionSecs': position.inSeconds});
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WatchProgressEntity?>> getProgress(
      String contentId) async {
    try {
      final progress = await localDataSource.getProgress(contentId);
      return Right(progress);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAvailableQualities(
      String contentId) async {
    try {
      final qualities = await remoteDataSource.getAvailableQualities(contentId);
      return Right(qualities);
    } catch (e) {
      return const Right(['Auto', 'Low', 'Medium', 'High']);
    }
  }
}