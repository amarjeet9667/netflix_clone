import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/errors/error_mapper.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      await localDataSource.saveToken(user.token);
      await localDataSource.saveUser(user);
      return Right(user);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(String email, String password) async {
    try {
      final user = await remoteDataSource.register(email, password);
      await localDataSource.saveToken(user.token);
      await localDataSource.saveUser(user);
      return Right(user);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.deleteToken();
      await localDataSource.deleteUser();
      return const Right(null);
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final token = await localDataSource.getToken();
      if (token == null || token.isEmpty) {
        return const Left(UnexpectedFailure(message: 'No session token found.'));
      }
      final user = await localDataSource.getUser();
      if (user != null) {
        return Right(user);
      }
      return const Left(UnexpectedFailure(message: 'User session not cached.'));
    } on Exception catch (e) {
      return Left(ErrorMapper.fromException(e));
    }
  }
}
