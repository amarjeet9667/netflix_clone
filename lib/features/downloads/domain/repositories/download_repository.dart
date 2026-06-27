// lib/features/downloads/domain/repositories/download_repository.dart

import 'package:dartz/dartz.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';
import '../entities/download_entity.dart';

abstract class DownloadRepository {
  /// Get all downloads from local storage
  Future<Either<Failure, List<DownloadEntity>>> getDownloads();

  /// Start a new download — returns the created DownloadEntity
  Future<Either<Failure, DownloadEntity>> startDownload({
    required String          contentId,
    required ContentType     contentType,
    required String          title,
    required String          thumbnailUrl,
    required DownloadQuality quality,
  });

  /// Cancel an in-progress download
  Future<Either<Failure, void>> cancelDownload({
    required String contentId,
  });

  /// Delete a completed download from local storage
  Future<Either<Failure, void>> deleteDownload({
    required String downloadId,
  });

  /// Delete all downloads
  Future<Either<Failure, void>> deleteAllDownloads();

  /// Update download progress (called by background task)
  Future<Either<Failure, DownloadEntity>> updateProgress({
    required String contentId,
    required double progress,
  });

  /// Get available quality options for a content item
  Future<Either<Failure, List<DownloadQuality>>> getAvailableQualities({
    required String contentId,
  });

  /// Check if a specific content item is already downloaded
  Future<Either<Failure, bool>> isDownloaded({
    required String contentId,
  });
}