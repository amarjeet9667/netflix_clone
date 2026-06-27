// lib/features/downloads/domain/usecases/cancel_download_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/download_repository.dart';

class CancelDownloadParams extends Equatable {
  final String contentId;
  const CancelDownloadParams({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class CancelDownloadUseCase {
  final DownloadRepository repository;
  const CancelDownloadUseCase(this.repository);

  Future<Either<Failure, void>> call(CancelDownloadParams params) {
    return repository.cancelDownload(contentId: params.contentId);
  }
}