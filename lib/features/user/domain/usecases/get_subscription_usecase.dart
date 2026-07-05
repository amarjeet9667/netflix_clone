// lib/features/user/domain/usecases/get_subscription_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/subscription_entity.dart';
import '../repositories/user_repository.dart';

class GetSubscriptionUseCase {
  final UserRepository repository;
  const GetSubscriptionUseCase(this.repository);

  Future<Either<Failure, SubscriptionEntity>> call() {
    return repository.getSubscription();
  }
}
