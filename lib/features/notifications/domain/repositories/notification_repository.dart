// lib/features/notifications/domain/repositories/notification_repository.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  /// Fetch all notifications for the current user
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  /// Mark a single notification as read
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead();

  /// Register FCM device token with backend
  Future<Either<Failure, void>> registerDeviceToken(String token);

  /// Unregister device token (on logout)
  Future<Either<Failure, void>> unregisterDeviceToken(String token);

  /// Get unread notification count only (for badge)
  Future<Either<Failure, int>> getUnreadCount();
}