// lib/features/search/domain/usecases/save_search_history_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/search_repository.dart';

class SaveSearchHistoryParams extends Equatable {
  final String query;
  const SaveSearchHistoryParams({required this.query});
  @override
  List<Object?> get props => [query];
}

class SaveSearchHistoryUseCase {
  final SearchRepository repository;
  const SaveSearchHistoryUseCase(this.repository);

  Future<Either<Failure, void>> call(SaveSearchHistoryParams params) {
    return repository.saveSearchHistory(params.query);
  }
}