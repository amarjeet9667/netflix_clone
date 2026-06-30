// lib/features/tv_shows/domain/usecases/get_season_detail_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/season_entity.dart';
import '../repositories/tvshow_repository.dart';

class SeasonListParams extends Equatable {
  final int showId;
  const SeasonListParams({required this.showId});
  @override
  List<Object?> get props => [showId];
}

class GetSeasonDetailUseCase {
  final TVShowRepository repository;
  const GetSeasonDetailUseCase(this.repository);

  Future<Either<Failure, List<SeasonEntity>>> call(SeasonListParams params) {
    return repository.getSeasons(params.showId);
  }
}