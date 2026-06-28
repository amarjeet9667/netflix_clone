// lib/features/notifications/domain/usecases/mark_all_read_usecase.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../repositories/notification_repository.dart';

class MarkAllNotificationsReadUseCase {
  final NotificationRepository repository;
  const MarkAllNotificationsReadUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.markAllAsRead();
  }
}
