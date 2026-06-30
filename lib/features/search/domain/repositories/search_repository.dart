// lib/features/search/domain/repositories/search_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/search_result_entity.dart';
import '../entities/genre_entity.dart';

abstract class SearchRepository {
  /// Search movies + TV shows by free-text query
  Future<Either<Failure, List<SearchResultEntity>>> search(String query);

  /// Get all genres for the "Browse by Genre" grid
  Future<Either<Failure, List<GenreEntity>>> getGenres();

  /// Get content filtered by a single genre
  Future<Either<Failure, List<SearchResultEntity>>> getByGenre(String genreName);

  /// Get top/trending searches shown before the user types anything
  Future<Either<Failure, List<String>>> getTopSearches();

  /// Save a query to local search history
  Future<Either<Failure, void>> saveSearchHistory(String query);

  /// Get recent search history
  Future<Either<Failure, List<String>>> getSearchHistory();

  /// Clear search history
  Future<Either<Failure, void>> clearSearchHistory();
}