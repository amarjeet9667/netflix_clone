// lib/features/notifications/domain/usecases/register_device_token_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/notification_repository.dart';

class RegisterDeviceTokenParams extends Equatable {
  final String token;
  const RegisterDeviceTokenParams({required this.token});
  @override
  List<Object?> get props => [token];
}

class RegisterDeviceTokenUseCase {
  final NotificationRepository repository;
  const RegisterDeviceTokenUseCase(this.repository);

  Future<Either<Failure, void>> call(RegisterDeviceTokenParams params) {
    return repository.registerDeviceToken(params.token);
  }
}