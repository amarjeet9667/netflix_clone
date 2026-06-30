// lib/features/search/domain/usecases/get_content_by_genre_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/search_result_entity.dart';
import '../repositories/search_repository.dart';

class GenreFilterParams extends Equatable {
  final String genreName;
  const GenreFilterParams({required this.genreName});
  @override
  List<Object?> get props => [genreName];
}

class GetContentByGenreUseCase {
  final SearchRepository repository;
  const GetContentByGenreUseCase(this.repository);

  Future<Either<Failure, List<SearchResultEntity>>> call(GenreFilterParams params) {
    return repository.getByGenre(params.genreName);
  }
}