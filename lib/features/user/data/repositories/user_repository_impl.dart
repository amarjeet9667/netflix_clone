// lib/features/user/data/repositories/user_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import 'package:netflix_clone/core/networks/network_info.dart';
import 'package:netflix_clone/features/user/data/datasources/user_local_datasource.dart';
import 'package:netflix_clone/features/user/data/datasources/user_remote_datasource.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/user_account_entity.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserAccountEntity>> getAccount() async {
    try {
      final account = await remoteDataSource.getAccount();
      return Right(account);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> getProfiles() async {
    try {
      final profiles = await remoteDataSource.getProfiles();
      return Right(profiles);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> createProfile({
    required String name,
    String? avatarUrl,
    required bool isKids,
  }) async {
    try {
      final profile = await remoteDataSource.createProfile(
        name: name,
        avatarUrl: avatarUrl,
        isKids: isKids,
      );
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String profileId,
    required String name,
    String? avatarUrl,
    required bool isKids,
    required String maturityRating,
  }) async {
    try {
      final profile = await remoteDataSource.updateProfile(
        profileId: profileId,
        name: name,
        avatarUrl: avatarUrl,
        isKids: isKids,
        maturityRating: maturityRating,
      );
      return Right(profile);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile(String profileId) async {
    try {
      await remoteDataSource.deleteProfile(profileId);
      // Also clear active profile if the deleted one was active
      final activeId = await localDataSource.getActiveProfileId();
      if (activeId == profileId) {
        await localDataSource.clearActiveProfileId();
      }
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> switchProfile(String profileId) async {
    try {
      // Fetch all profiles then find the target
      final profiles = await remoteDataSource.getProfiles();
      final profile = profiles.firstWhere(
        (p) => p.id == profileId,
        orElse: () => throw NotFoundException('Profile not found.'),
      );
      // Persist locally
      await localDataSource.saveActiveProfileId(profileId);
      return Right(profile);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getActiveProfileId() async {
    try {
      final id = await localDataSource.getActiveProfileId();
      return Right(id);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity>> getSubscription() async {
    try {
      final sub = await remoteDataSource.getSubscription();
      return Right(sub);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmail(String newEmail) async {
    try {
      await remoteDataSource.getAccount(); // verify connection
      // TODO: await remoteDataSource.updateEmail(newEmail);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // TODO: await remoteDataSource.updatePassword(...)
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
