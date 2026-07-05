// lib/features/watchlist/domain/repositories/watchlist_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../entities/watchlist_entity.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<WatchlistEntity>>> getMyList();
  Future<Either<Failure, List<WatchlistEntity>>> getContinueWatching();
  Future<Either<Failure, bool>> toggleWatchlist({
    required String contentId,
    required ContentType contentType,
  });
}
