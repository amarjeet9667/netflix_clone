// lib/features/user/domain/usecases/get_profile_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/user_repository.dart';

class GetProfileUseCase {
  final UserRepository repository;
  const GetProfileUseCase(this.repository);

  Future<Either<Failure, List<ProfileEntity>>> call() {
    return repository.getProfiles();
  }
}
