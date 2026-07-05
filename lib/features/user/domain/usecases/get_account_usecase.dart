// lib/features/user/domain/usecases/get_account_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/user_account_entity.dart';
import '../repositories/user_repository.dart';

class GetAccountUseCase {
  final UserRepository repository;
  const GetAccountUseCase(this.repository);

  Future<Either<Failure, UserAccountEntity>> call() {
    return repository.getAccount();
  }
}
