// lib/features/watchlist/domain/usecases/get_continue_watching_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/watchlist_entity.dart';
import '../repositories/watchlist_repository.dart';

class GetContinueWatchingUseCase {
  final WatchlistRepository repository;
  const GetContinueWatchingUseCase(this.repository);

  Future<Either<Failure, List<WatchlistEntity>>> call() {
    return repository.getContinueWatching();
  }
}
