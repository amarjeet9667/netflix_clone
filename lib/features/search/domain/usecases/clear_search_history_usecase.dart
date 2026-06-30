// lib/features/search/domain/usecases/clear_search_history_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/search_repository.dart';

class ClearSearchHistoryUseCase {
  final SearchRepository repository;
  const ClearSearchHistoryUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.clearSearchHistory();
  }
}