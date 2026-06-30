// lib/features/player/domain/usecases/get_subtitles_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/subtitle_entity.dart';
import '../repositories/player_repository.dart';

class SubtitlesParams extends Equatable {
  final String contentId;
  const SubtitlesParams({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class GetSubtitlesUseCase {
  final PlayerRepository repository;
  const GetSubtitlesUseCase(this.repository);

  Future<Either<Failure, List<SubtitleEntity>>> call(SubtitlesParams params) {
    return repository.getSubtitles(params.contentId);
  }
}
