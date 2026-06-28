// lib/features/notifications/domain/entities/notification_entity.dart
import 'package:equatable/equatable.dart';

enum NotificationType {
  newEpisode,
  newRelease,
  reminder,
  recommendation,
  accountAlert,
}

class NotificationEntity extends Equatable {
  final String           id;
  final NotificationType type;
  final String           title;
  final String           body;
  final String           imageUrl;
  final int?             contentId;
  final bool             isRead;
  final DateTime         createdAt;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.imageUrl,
    this.contentId,
    required this.isRead,
    required this.createdAt,
  });

  /// Relative time label e.g. "2h ago", "3d ago"
  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60)  return '${diff.inMinutes}m ago';
    if (diff.inHours   < 24)  return '${diff.inHours}h ago';
    if (diff.inDays    < 7)   return '${diff.inDays}d ago';
    return '${(diff.inDays / 7).round()}w ago';
  }

  NotificationEntity copyWith({
    String?           id,
    NotificationType? type,
    String?           title,
    String?           body,
    String?           imageUrl,
    int?              contentId,
    bool?             isRead,
    DateTime?         createdAt,
  }) {
    return NotificationEntity(
      id:        id        ?? this.id,
      type:      type      ?? this.type,
      title:     title     ?? this.title,
      body:      body      ?? this.body,
      imageUrl:  imageUrl  ?? this.imageUrl,
      contentId: contentId ?? this.contentId,
      isRead:    isRead    ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, type, title, body, imageUrl, contentId, isRead, createdAt];
}