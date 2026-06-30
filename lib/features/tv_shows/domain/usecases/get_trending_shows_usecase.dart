// lib/features/tv_shows/domain/usecases/get_trending_shows_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/series_entity.dart';
import '../repositories/tvshow_repository.dart';

class GetTrendingShowsUseCase {
  final TVShowRepository repository;
  const GetTrendingShowsUseCase(this.repository);

  Future<Either<Failure, List<SeriesEntity>>> call() {
    return repository.getTrendingShows();
  }
}