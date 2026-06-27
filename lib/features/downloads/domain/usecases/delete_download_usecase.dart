// lib/features/downloads/domain/usecases/delete_download_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/download_repository.dart';

class DeleteDownloadParams extends Equatable {
  final String downloadId;
  const DeleteDownloadParams({required this.downloadId});
  @override
  List<Object?> get props => [downloadId];
}

class DeleteDownloadUseCase {
  final DownloadRepository repository;
  const DeleteDownloadUseCase(this.repository);

  Future<Either<Failure, void>> call(DeleteDownloadParams params) {
    return repository.deleteDownload(downloadId: params.downloadId);
  }
}