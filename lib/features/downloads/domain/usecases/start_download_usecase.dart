// lib/features/downloads/domain/usecases/start_download_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';
import '../entities/download_entity.dart';
import '../repositories/download_repository.dart';

class StartDownloadParams extends Equatable {
  final String          contentId;
  final ContentType     contentType;
  final String          title;
  final String          thumbnailUrl;
  final DownloadQuality quality;

  const StartDownloadParams({
    required this.contentId,
    required this.contentType,
    required this.title,
    required this.thumbnailUrl,
    required this.quality,
  });

  @override
  List<Object?> get props => [contentId, contentType, quality];
}

class StartDownloadUseCase {
  final DownloadRepository repository;
  const StartDownloadUseCase(this.repository);

  Future<Either<Failure, DownloadEntity>> call(StartDownloadParams params) {
    return repository.startDownload(
      contentId:    params.contentId,
      contentType:  params.contentType,
      title:        params.title,
      thumbnailUrl: params.thumbnailUrl,
      quality:      params.quality,
    );
  }
}