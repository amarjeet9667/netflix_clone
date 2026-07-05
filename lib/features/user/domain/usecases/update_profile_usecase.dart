// lib/features/user/domain/usecases/update_profile_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_repository.dart';

class UpdateProfileParams extends Equatable {
  final String profileId;
  final String name;
  final String? avatarUrl;
  final bool isKids;
  final String maturityRating;

  const UpdateProfileParams({
    required this.profileId,
    required this.name,
    this.avatarUrl,
    required this.isKids,
    required this.maturityRating,
  });

  @override
  List<Object?> get props => [
    profileId,
    name,
    avatarUrl,
    isKids,
    maturityRating,
  ];
}

class UpdateProfileUseCase {
  final UserRepository repository;
  const UpdateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      profileId: params.profileId,
      name: params.name,
      avatarUrl: params.avatarUrl,
      isKids: params.isKids,
      maturityRating: params.maturityRating,
    );
  }
}
