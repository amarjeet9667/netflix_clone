// lib/features/search/domain/usecases/search_content_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

class SearchParams extends Equatable {
  final String query;
  const SearchParams({required this.query});
  @override
  List<Object?> get props => [query];
}

class SearchContentUseCase {
  final SearchRepository repository;
  const SearchContentUseCase(this.repository);

  Future<Either<Failure, List<SearchResultEntity>>> call(SearchParams params) {
    return repository.search(params.query);
  }
}