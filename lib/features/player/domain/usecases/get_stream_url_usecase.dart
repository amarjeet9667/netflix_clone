// lib/features/player/domain/usecases/get_stream_url_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/player_repository.dart';

class StreamUrlParams extends Equatable {
  final String contentId;
  const StreamUrlParams({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

class GetStreamUrlUseCase {
  final PlayerRepository repository;
  const GetStreamUrlUseCase(this.repository);

  Future<Either<Failure, String>> call(StreamUrlParams params) async {
    final result = await repository.getStreamUrl(params.contentId);
    return result.fold(
      (failure) => Left(failure),
      (playback) => Right(playback.streamUrl),
    );
  }
}