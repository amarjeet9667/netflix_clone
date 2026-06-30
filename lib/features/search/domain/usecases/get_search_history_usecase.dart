// lib/features/search/domain/usecases/get_search_history_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/search_repository.dart';

class GetSearchHistoryUseCase {
  final SearchRepository repository;
  const GetSearchHistoryUseCase(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getSearchHistory();
  }
}