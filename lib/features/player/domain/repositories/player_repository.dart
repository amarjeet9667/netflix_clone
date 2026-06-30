// lib/features/player/domain/repositories/player_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/playback_entity.dart';
import '../entities/subtitle_entity.dart';
import '../entities/watch_progress_entity.dart';

abstract class PlayerRepository {
  /// Resolve the stream URL for a content item + resume position
  Future<Either<Failure, PlaybackEntity>> getStreamUrl(String contentId);

  /// Fetch available subtitle tracks
  Future<Either<Failure, List<SubtitleEntity>>> getSubtitles(String contentId);

  /// Save watch progress to local cache (and optionally remote)
  Future<Either<Failure, void>> saveProgress({
    required String   contentId,
    required Duration position,
    required Duration duration,
  });

  /// Get saved progress for a content item
  Future<Either<Failure, WatchProgressEntity?>> getProgress(String contentId);

  /// Get available stream qualities for a content item
  Future<Either<Failure, List<String>>> getAvailableQualities(String contentId);
}