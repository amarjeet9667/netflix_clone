// lib/features/player/data/models/playback_model.dart
import '../../domain/entities/playback_entity.dart';

class PlaybackModel extends PlaybackEntity {
  const PlaybackModel({
    required super.contentId,
    required super.streamUrl,
    super.savedPosition,
    super.totalDuration,
  });

  factory PlaybackModel.fromJson(Map<String, dynamic> json) {
    return PlaybackModel(
      contentId: json['contentId'] as String,
      streamUrl: json['streamUrl'] as String,
      savedPosition: Duration(seconds: json['savedPositionSecs'] as int? ?? 0),
      totalDuration: Duration(seconds: json['totalDurationSecs'] as int? ?? 0),
    );
  }

  /// Build a dummy playback from a content ID
  factory PlaybackModel.dummy(String contentId) {
    return PlaybackModel(
      contentId: contentId,
      // Public domain Big Buck Bunny — works without a real CDN
      streamUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    );
  }

  Map<String, dynamic> toJson() => {
    'contentId': contentId,
    'streamUrl': streamUrl,
    'savedPositionSecs': savedPosition.inSeconds,
    'totalDurationSecs': totalDuration.inSeconds,
  };
}
