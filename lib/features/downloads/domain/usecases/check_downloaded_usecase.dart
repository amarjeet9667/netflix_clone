// lib/features/downloads/domain/usecases/check_downloaded_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/download_repository.dart';

class CheckDownloadedParams extends Equatable {
  final String contentId;
  const CheckDownloadedParams({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class CheckDownloadedUseCase {
  final DownloadRepository repository;
  const CheckDownloadedUseCase(this.repository);

  Future<Either<Failure, bool>> call(CheckDownloadedParams params) {
    return repository.isDownloaded(contentId: params.contentId);
  }
}