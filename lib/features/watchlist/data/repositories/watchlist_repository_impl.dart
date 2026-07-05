// lib/features/watchlist/data/repositories/watchlist_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../../domain/entities/watchlist_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_local_datasource.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  const WatchlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<WatchlistEntity>>> getMyList() async {
    try {
      final list = await localDataSource.getMyList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WatchlistEntity>>> getContinueWatching() async {
    try {
      final list = await localDataSource.getContinueWatching();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleWatchlist({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      final isAdded = await localDataSource.toggleWatchlist(
        contentId: contentId,
        contentType: contentType.name,
      );
      return Right(isAdded);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
