// lib/features/downloads/data/repositories/download_repository_impl.dart

import 'package:dartz/dartz.dart';

import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';
import '../../domain/entities/download_entity.dart';
import '../../domain/repositories/download_repository.dart';
import '../datasources/download_local_datasource.dart';
import '../models/download_model.dart';

class DownloadRepositoryImpl implements DownloadRepository {
  final DownloadLocalDataSource localDataSource;

  const DownloadRepositoryImpl({required this.localDataSource});

  // ── Get all downloads ────────────────────────────────────
  @override
  Future<Either<Failure, List<DownloadEntity>>> getDownloads() async {
    try {
      final models = await localDataSource.getDownloads();
      return Right(models);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Start download ────────────────────────────────────────
  @override
  Future<Either<Failure, DownloadEntity>> startDownload({
    required String          contentId,
    required ContentType     contentType,
    required String          title,
    required String          thumbnailUrl,
    required DownloadQuality quality,
  }) async {
    try {
      // Check for duplicate
      final existing = await localDataSource.isDownloaded(contentId);
      if (existing) {
        return Left(ConflictFailure(
          message: '"$title" is already downloaded.',
        ));
      }

      final model = DownloadModel(
        id:           '${contentId}_${DateTime.now().millisecondsSinceEpoch}',
        contentId:    contentId,
        contentType:  contentType,
        title:        title,
        thumbnailUrl: thumbnailUrl,
        quality:      quality,
        status:       DownloadStatus.downloading,
        progress:     0.0,
        fileSizeMB:   _estimateSizeMB(quality),
        expiresAt:    DateTime.now().add(const Duration(days: 30)),
      );

      final saved = await localDataSource.saveDownload(model);
      return Right(saved);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Cancel download ───────────────────────────────────────
  @override
  Future<Either<Failure, void>> cancelDownload({
    required String contentId,
  }) async {
    try {
      final all = await localDataSource.getDownloads();
      final match = all.where((d) =>
        d.contentId == contentId &&
        d.status == DownloadStatus.downloading,
      );
      for (final d in match) {
        await localDataSource.deleteDownload(d.id);
      }
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Delete download ───────────────────────────────────────
  @override
  Future<Either<Failure, void>> deleteDownload({
    required String downloadId,
  }) async {
    try {
      await localDataSource.deleteDownload(downloadId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Delete all ────────────────────────────────────────────
  @override
  Future<Either<Failure, void>> deleteAllDownloads() async {
    try {
      await localDataSource.deleteAllDownloads();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Update progress ───────────────────────────────────────
  @override
  Future<Either<Failure, DownloadEntity>> updateProgress({
    required String contentId,
    required double progress,
  }) async {
    try {
      final all   = await localDataSource.getDownloads();
      final match = all.firstWhere(
        (d) => d.contentId == contentId &&
               d.status == DownloadStatus.downloading,
        orElse: () => throw CacheException('Download not found.'),
      );

      final isDone  = progress >= 1.0;
      final updated = match.copyWith(
        progress:     progress,
        status:       isDone ? DownloadStatus.completed : DownloadStatus.downloading,
        downloadedAt: isDone ? DateTime.now() : null,
      );

      final saved = await localDataSource.updateDownload(updated);
      return Right(saved);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Get available qualities ───────────────────────────────
  @override
  Future<Either<Failure, List<DownloadQuality>>> getAvailableQualities({
    required String contentId,
  }) async {
    // In production: call API to get available qualities for this content
    return const Right([
      DownloadQuality.low,
      DownloadQuality.medium,
      DownloadQuality.high,
    ]);
  }

  // ── Is downloaded ─────────────────────────────────────────
  @override
  Future<Either<Failure, bool>> isDownloaded({
    required String contentId,
  }) async {
    try {
      final result = await localDataSource.isDownloaded(contentId);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // ── Helper ────────────────────────────────────────────────
  int _estimateSizeMB(DownloadQuality quality) {
    switch (quality) {
      case DownloadQuality.low:    return 300;
      case DownloadQuality.medium: return 700;
      case DownloadQuality.high:   return 1400;
    }
  }
}