// lib/features/tv_shows/domain/usecases/get_episodes_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/episode_entity.dart';
import '../repositories/tvshow_repository.dart';

class EpisodesParams extends Equatable {
  final String showId;       // kept as String to match BLoC call sites
  final int    seasonNumber;
  const EpisodesParams({
    required this.showId,
    required this.seasonNumber,
  });
  @override
  List<Object?> get props => [showId, seasonNumber];
}

class GetEpisodesUseCase {
  final TVShowRepository repository;
  const GetEpisodesUseCase(this.repository);

  Future<Either<Failure, List<EpisodeEntity>>> call(EpisodesParams params) {
    return repository.getEpisodes(
      showId:       int.parse(params.showId),
      seasonNumber: params.seasonNumber,
    );
  }
}