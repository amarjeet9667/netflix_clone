// lib/features/user/domain/usecases/create_profile_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_repository.dart';

class CreateProfileParams extends Equatable {
  final String name;
  final String? avatarUrl;
  final bool isKids;

  const CreateProfileParams({
    required this.name,
    this.avatarUrl,
    required this.isKids,
  });

  @override
  List<Object?> get props => [name, avatarUrl, isKids];
}

class CreateProfileUseCase {
  final UserRepository repository;
  const CreateProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(CreateProfileParams params) {
    return repository.createProfile(
      name: params.name,
      avatarUrl: params.avatarUrl,
      isKids: params.isKids,
    );
  }
}
