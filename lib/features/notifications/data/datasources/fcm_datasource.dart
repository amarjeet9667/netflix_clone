// lib/features/notifications/data/datasources/fcm_datasource.dart
import 'package:flutter/foundation.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import '../models/notification_model.dart';

// ── Abstract ─────────────────────────────────────────────────
abstract class FCMDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead();
  Future<void> registerToken(String token);
  Future<void> unregisterToken(String token);
}

// ── Implementation ────────────────────────────────────────────
class FCMDataSourceImpl implements FCMDataSource {
  // In-memory store — mirrors server state until real FCM is wired
  final List<NotificationModel> _cache = [];
  bool _seeded = false;

  void _seed() {
    if (_seeded) return;
    _cache.addAll(
      DummyNotifications.notifications
          .map(NotificationModel.fromDummyMap),
    );
    _seeded = true;
  }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    try {
      _seed();
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));
      // Sorted newest first
      return List.from(_cache)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } catch (e) {
      throw ServerException(message: 'Failed to fetch notifications: $e');
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    _seed();
    final idx = _cache.indexWhere((n) => n.id == notificationId);
    if (idx == -1) throw ServerException(message: 'Notification not found.');
    _cache[idx] = _cache[idx].copyWith(isRead: true) as NotificationModel;
    // Real impl: await _apiClient.patch(ApiNotificationConstants.markRead(notificationId));
  }

  @override
  Future<void> markAllAsRead() async {
    _seed();
    for (int i = 0; i < _cache.length; i++) {
      _cache[i] = _cache[i].copyWith(isRead: true) as NotificationModel;
    }
    // Real impl: await _apiClient.post(ApiNotificationConstants.markAllRead);
  }

  @override
  Future<void> registerToken(String token) async {
    // Real impl:
    // await _apiClient.post(
    //   ApiNotificationConstants.registerToken,
    //   data: {'token': token, 'platform': Platform.isIOS ? 'apns' : 'fcm'},
    // );
    debugPrint('📱 FCM token registered: ${token.substring(0, 10)}…');
  }

  @override
  Future<void> unregisterToken(String token) async {
    // Real impl:
    // await _apiClient.post(ApiNotificationConstants.unregisterToken,
    //   data: {'token': token});
    debugPrint('📱 FCM token unregistered');
  }
}