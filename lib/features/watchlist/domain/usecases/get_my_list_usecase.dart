// lib/features/watchlist/domain/usecases/get_my_list_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/watchlist_entity.dart';
import '../repositories/watchlist_repository.dart';

class GetMyListUseCase {
  final WatchlistRepository repository;
  const GetMyListUseCase(this.repository);

  Future<Either<Failure, List<WatchlistEntity>>> call() {
    return repository.getMyList();
  }
}
