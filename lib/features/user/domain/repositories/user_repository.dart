// lib/features/user/domain/repositories/user_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/profile_entity.dart';
import '../entities/user_account_entity.dart';
import '../entities/subscription_entity.dart';

abstract class UserRepository {
  /// Logged-in account info (one per login)
  Future<Either<Failure, UserAccountEntity>> getAccount();

  /// All profiles under this account (who-is-watching screen)
  Future<Either<Failure, List<ProfileEntity>>> getProfiles();

  /// Create a new profile
  Future<Either<Failure, ProfileEntity>> createProfile({
    required String name,
    String? avatarUrl,
    required bool isKids,
  });

  /// Update an existing profile
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String profileId,
    required String name,
    String? avatarUrl,
    required bool isKids,
    required String maturityRating,
  });

  /// Delete a profile
  Future<Either<Failure, void>> deleteProfile(String profileId);

  /// Switch active profile (sets local "current profile" pointer)
  Future<Either<Failure, ProfileEntity>> switchProfile(String profileId);

  /// Currently active profile ID (persisted locally)
  Future<Either<Failure, String?>> getActiveProfileId();

  /// Subscription / billing info
  Future<Either<Failure, SubscriptionEntity>> getSubscription();

  /// Update account email
  Future<Either<Failure, void>> updateEmail(String newEmail);

  /// Update account password
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
}