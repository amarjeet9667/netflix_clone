// lib/features/notifications/presentation/bloc/notification_event.dart
part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

/// Load notifications list
class NotificationFetchEvent extends NotificationEvent {
  const NotificationFetchEvent();
}

/// Register FCM device token with backend
class NotificationRegisterTokenEvent extends NotificationEvent {
  final String token;
  const NotificationRegisterTokenEvent({required this.token});
  @override
  List<Object?> get props => [token];
}

/// Mark a single notification as read
class NotificationMarkReadEvent extends NotificationEvent {
  final String notificationId;
  const NotificationMarkReadEvent({required this.notificationId});
  @override
  List<Object?> get props => [notificationId];
}

/// Mark all notifications as read
class NotificationMarkAllReadEvent extends NotificationEvent {
  const NotificationMarkAllReadEvent();
}

/// A new push notification arrived while app is open
class NotificationReceivedEvent extends NotificationEvent {
  final NotificationEntity notification;
  const NotificationReceivedEvent({required this.notification});
  @override
  List<Object?> get props => [notification];
}