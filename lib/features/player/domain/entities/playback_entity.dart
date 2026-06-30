// lib/features/player/domain/entities/playback_entity.dart
import 'package:equatable/equatable.dart';

class PlaybackEntity extends Equatable {
  final String   contentId;
  final String   streamUrl;
  final Duration savedPosition; // resume point
  final Duration totalDuration;

  const PlaybackEntity({
    required this.contentId,
    required this.streamUrl,
    this.savedPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });

  double get resumeProgress =>
      totalDuration.inMilliseconds > 0
          ? savedPosition.inMilliseconds / totalDuration.inMilliseconds
          : 0.0;

  @override
  List<Object?> get props =>
      [contentId, streamUrl, savedPosition, totalDuration];
}