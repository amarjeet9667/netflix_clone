// lib/features/notifications/data/models/notification_model.dart
import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.type,
    required super.title,
    required super.body,
    required super.imageUrl,
    super.contentId,
    required super.isRead,
    required super.createdAt,
  });

  // ── From dummy data map ───────────────────────────────────
  factory NotificationModel.fromDummyMap(Map<String, dynamic> map) {
    return NotificationModel(
      id:        map['id'] as String,
      type:      _parseType(map['type'] as String),
      title:     map['title'] as String,
      body:      map['body'] as String,
      imageUrl:  map['imageUrl'] as String,
      contentId: map['contentId'] as int?,
      isRead:    map['isRead'] as bool? ?? false,
      createdAt: DateTime.tryParse(
            map['createdAt'] as String? ?? '',
          ) ??
          DateTime.now(),
    );
  }

  // ── From API JSON ─────────────────────────────────────────
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id:        json['id'] as String,
      type:      _parseType(json['type'] as String? ?? ''),
      title:     json['title'] as String,
      body:      json['body'] as String,
      imageUrl:  json['imageUrl'] as String? ?? '',
      contentId: json['contentId'] as int?,
      isRead:    json['isRead'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  // ── To JSON ───────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'id':        id,
      'type':      type.name,
      'title':     title,
      'body':      body,
      'imageUrl':  imageUrl,
      'contentId': contentId,
      'isRead':    isRead,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ── From entity ───────────────────────────────────────────
  factory NotificationModel.fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id:        entity.id,
      type:      entity.type,
      title:     entity.title,
      body:      entity.body,
      imageUrl:  entity.imageUrl,
      contentId: entity.contentId,
      isRead:    entity.isRead,
      createdAt: entity.createdAt,
    );
  }

  @override
  NotificationModel copyWith({
    String?           id,
    NotificationType? type,
    String?           title,
    String?           body,
    String?           imageUrl,
    int?              contentId,
    bool?             isRead,
    DateTime?         createdAt,
  }) {
    return NotificationModel(
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

  // ── Helper ────────────────────────────────────────────────
  static NotificationType _parseType(String raw) {
    switch (raw) {
      case 'new_episode':     return NotificationType.newEpisode;
      case 'new_release':     return NotificationType.newRelease;
      case 'reminder':        return NotificationType.reminder;
      case 'recommendation':  return NotificationType.recommendation;
      case 'account_alert':   return NotificationType.accountAlert;
      default:                return NotificationType.newRelease;
    }
  }
}
