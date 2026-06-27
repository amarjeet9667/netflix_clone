import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/errors/error_mapper.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';
import '../datasources/movie_local_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      final movies = await remoteDataSource.getTrendingMovies();
      return Right(movies);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, MovieEntity>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getSimilarMovies(int movieId) async {
    try {
      final movies = await remoteDataSource.getSimilarMovies(movieId);
      return Right(movies);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query) async {
    try {
      final movies = await remoteDataSource.searchMovies(query);
      return Right(movies);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }
}
