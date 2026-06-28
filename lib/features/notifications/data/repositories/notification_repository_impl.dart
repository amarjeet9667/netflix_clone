// lib/features/notifications/data/repositories/notification_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/errors/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/fcm_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final FCMDataSource fcmDataSource;

  const NotificationRepositoryImpl({required this.fcmDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final models = await fcmDataSource.getNotifications();
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      await fcmDataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await fcmDataSource.markAllAsRead();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerDeviceToken(String token) async {
    try {
      await fcmDataSource.registerToken(token);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unregisterDeviceToken(String token) async {
    try {
      await fcmDataSource.unregisterToken(token);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final models = await fcmDataSource.getNotifications();
      return Right(models.where((n) => !n.isRead).length);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}