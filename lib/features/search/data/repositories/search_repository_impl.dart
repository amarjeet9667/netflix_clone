// lib/features/search/data/repositories/search_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_datasource.dart';
import '../datasources/search_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SearchResultEntity>>> search(String query) async {
    try {
      final results = await remoteDataSource.search(query);
      // Fire-and-forget: save to history on successful search
      if (results.isNotEmpty) {
        unawaited(localDataSource.saveSearchQuery(query));
      }
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenres() async {
    try {
      final genres = await remoteDataSource.getGenres();
      return Right(genres);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SearchResultEntity>>> getByGenre(
    String genreName,
  ) async {
    try {
      final results = await remoteDataSource.getByGenre(genreName);
      return Right(results);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTopSearches() async {
    try {
      final top = await remoteDataSource.getTopSearches();
      return Right(top);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSearchHistory(String query) async {
    try {
      await localDataSource.saveSearchQuery(query);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSearchHistory() async {
    try {
      final history = await localDataSource.getSearchHistory();
      return Right(history);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      await localDataSource.clearSearchHistory();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}

/// Lightweight helper so we don't need to import dart:async just for this
void unawaited(Future<void> future) {}
