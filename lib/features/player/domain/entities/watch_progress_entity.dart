// lib/features/player/domain/entities/watch_progress_entity.dart
import 'package:equatable/equatable.dart';

class WatchProgressEntity extends Equatable {
  final String   contentId;
  final Duration position;
  final Duration duration;
  final DateTime savedAt;

  const WatchProgressEntity({
    required this.contentId,
    required this.position,
    required this.duration,
    required this.savedAt,
  });

  double get progress =>
      duration.inMilliseconds > 0
          ? position.inMilliseconds / duration.inMilliseconds
          : 0.0;

  bool get isCompleted => progress >= 0.95;

  String get remainingLabel {
    final remaining = duration - position;
    final m = remaining.inMinutes;
    final h = m ~/ 60;
    return h > 0 ? '${h}h ${m % 60}m remaining' : '${m}m remaining';
  }

  @override
  List<Object?> get props => [contentId, position, duration, savedAt];
}