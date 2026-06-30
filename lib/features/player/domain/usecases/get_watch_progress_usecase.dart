// lib/features/player/domain/usecases/get_watch_progress_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/watch_progress_entity.dart';
import '../repositories/player_repository.dart';

class GetProgressParams extends Equatable {
  final String contentId;
  const GetProgressParams({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class GetWatchProgressUseCase {
  final PlayerRepository repository;
  const GetWatchProgressUseCase(this.repository);

  Future<Either<Failure, WatchProgressEntity?>> call(GetProgressParams params) {
    return repository.getProgress(params.contentId);
  }
}
