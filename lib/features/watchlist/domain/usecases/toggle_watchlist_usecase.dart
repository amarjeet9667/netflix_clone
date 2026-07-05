// lib/features/watchlist/domain/usecases/toggle_watchlist_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../repositories/watchlist_repository.dart';

class ToggleParams extends Equatable {
  final String contentId;
  final ContentType contentType;

  const ToggleParams({
    required this.contentId,
    required this.contentType,
  });

  @override
  List<Object?> get props => [contentId, contentType];
}

class ToggleWatchlistUseCase {
  final WatchlistRepository repository;
  const ToggleWatchlistUseCase(this.repository);

  Future<Either<Failure, bool>> call(ToggleParams params) {
    return repository.toggleWatchlist(
      contentId: params.contentId,
      contentType: params.contentType,
    );
  }
}
