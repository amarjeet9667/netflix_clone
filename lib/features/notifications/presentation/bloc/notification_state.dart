// lib/features/notifications/presentation/bloc/notification_state.dart
part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationLoaded({required this.notifications});

  /// Number of unread notifications (drives badge on nav bar)
  int get unreadCount =>
      notifications.where((n) => !n.isRead).length;

  bool get hasUnread => unreadCount > 0;

  /// Return a copy with one notification marked read
  NotificationLoaded markRead(String id) {
    return NotificationLoaded(
      notifications: notifications.map((n) {
        return n.id == id ? n.copyWith(isRead: true) : n;
      }).toList(),
    );
  }

  /// Return a copy with all notifications marked read
  NotificationLoaded markAllRead() {
    return NotificationLoaded(
      notifications: notifications
          .map((n) => n.copyWith(isRead: true))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [notifications];
}

class NotificationError extends NotificationState {
  final String message;
  const NotificationError({required this.message});
  @override
  List<Object?> get props => [message];
}