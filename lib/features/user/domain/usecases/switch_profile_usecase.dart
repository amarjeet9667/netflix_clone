// lib/features/user/domain/usecases/switch_profile_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_repository.dart';

class SwitchProfileParams extends Equatable {
  final String profileId;
  const SwitchProfileParams({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

class SwitchProfileUseCase {
  final UserRepository repository;
  const SwitchProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(SwitchProfileParams params) {
    return repository.switchProfile(params.profileId);
  }
}
