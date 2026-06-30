// lib/features/search/domain/usecases/get_genre_list_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/genre_entity.dart';
import '../repositories/search_repository.dart';

class GetGenreListUseCase {
  final SearchRepository repository;
  const GetGenreListUseCase(this.repository);

  Future<Either<Failure, List<GenreEntity>>> call() {
    return repository.getGenres();
  }
}