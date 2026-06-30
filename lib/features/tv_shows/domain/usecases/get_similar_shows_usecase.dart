// lib/features/tv_shows/domain/usecases/get_similar_shows_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/series_entity.dart';
import '../repositories/tvshow_repository.dart';

class SimilarShowsParams extends Equatable {
  final int showId;
  const SimilarShowsParams({required this.showId});
  @override
  List<Object?> get props => [showId];
}

class GetSimilarShowsUseCase {
  final TVShowRepository repository;
  const GetSimilarShowsUseCase(this.repository);

  Future<Either<Failure, List<SeriesEntity>>> call(SimilarShowsParams params) {
    return repository.getSimilarShows(params.showId);
  }
}
