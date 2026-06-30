// lib/features/player/domain/usecases/save_watch_progress_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/player_repository.dart';

class SaveProgressParams extends Equatable {
  final String   contentId;
  final Duration position;
  final Duration duration;
  const SaveProgressParams({
    required this.contentId,
    required this.position,
    required this.duration,
  });
  @override
  List<Object?> get props => [contentId, position, duration];
}

class SaveWatchProgressUseCase {
  final PlayerRepository repository;
  const SaveWatchProgressUseCase(this.repository);

  Future<Either<Failure, void>> call(SaveProgressParams params) {
    return repository.saveProgress(
      contentId: params.contentId,
      position:  params.position,
      duration:  params.duration,
    );
  }
}
