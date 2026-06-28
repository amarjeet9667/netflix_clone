// lib/features/downloads/domain/usecases/get_downloads_usecase.dart
import 'package:dartz/dartz.dart';

import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/download_entity.dart';
import '../repositories/download_repository.dart';

class GetDownloadsUseCase {
  final DownloadRepository repository;
  const GetDownloadsUseCase(this.repository);

  Future<Either<Failure, List<DownloadEntity>>> call() {
    return repository.getDownloads();
  }
}