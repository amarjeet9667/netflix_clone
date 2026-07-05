// lib/features/user/domain/usecases/delete_profile_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/user_repository.dart';

class DeleteProfileParams extends Equatable {
  final String profileId;
  const DeleteProfileParams({required this.profileId});
  @override
  List<Object?> get props => [profileId];
}

class DeleteProfileUseCase {
  final UserRepository repository;
  const DeleteProfileUseCase(this.repository);

  Future<Either<Failure, void>> call(DeleteProfileParams params) {
    return repository.deleteProfile(params.profileId);
  }
}
