// lib/features/notifications/domain/usecases/mark_notification_read_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/notification_repository.dart';

class MarkNotificationReadParams extends Equatable {
  final String notificationId;
  const MarkNotificationReadParams({required this.notificationId});
  @override
  List<Object?> get props => [notificationId];
}

class MarkNotificationReadUseCase {
  final NotificationRepository repository;
  const MarkNotificationReadUseCase(this.repository);

  Future<Either<Failure, void>> call(MarkNotificationReadParams params) {
    return repository.markAsRead(params.notificationId);
  }
}