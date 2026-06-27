// lib/features/player/presentation/bloc/player_event.dart
part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();
  @override
  List<Object?> get props => [];
}

/// Initialize player with a content ID
class PlayerInitEvent extends PlayerEvent {
  final String contentId;
  final String contentType; // 'movie' | 'episode'
  const PlayerInitEvent({
    required this.contentId,
    required this.contentType,
  });
  @override
  List<Object?> get props => [contentId, contentType];
}

/// Resume / pause toggle
class PlayerTogglePlayPauseEvent extends PlayerEvent {
  const PlayerTogglePlayPauseEvent();
}

/// Seek to a position
class PlayerSeekEvent extends PlayerEvent {
  final Duration position;
  const PlayerSeekEvent({required this.position});
  @override
  List<Object?> get props => [position];
}

/// Skip forward N seconds
class PlayerSkipForwardEvent extends PlayerEvent {
  final int seconds;
  const PlayerSkipForwardEvent({this.seconds = 10});
  @override
  List<Object?> get props => [seconds];
}

/// Skip backward N seconds
class PlayerSkipBackwardEvent extends PlayerEvent {
  final int seconds;
  const PlayerSkipBackwardEvent({this.seconds = 10});
  @override
  List<Object?> get props => [seconds];
}

/// Mute / unmute
class PlayerToggleMuteEvent extends PlayerEvent {
  const PlayerToggleMuteEvent();
}

/// Change volume
class PlayerSetVolumeEvent extends PlayerEvent {
  final double volume; // 0.0 – 1.0
  const PlayerSetVolumeEvent({required this.volume});
  @override
  List<Object?> get props => [volume];
}

/// Change subtitle track
class PlayerSelectSubtitleEvent extends PlayerEvent {
  final String? language; // null = off
  const PlayerSelectSubtitleEvent({this.language});
  @override
  List<Object?> get props => [language];
}

/// Change quality
class PlayerSelectQualityEvent extends PlayerEvent {
  final String quality; // 'Auto' | 'Low' | 'Medium' | 'High'
  const PlayerSelectQualityEvent({required this.quality});
  @override
  List<Object?> get props => [quality];
}

/// Show / hide controls overlay
class PlayerToggleControlsEvent extends PlayerEvent {
  const PlayerToggleControlsEvent();
}

/// Periodic position update from video controller
class PlayerPositionChangedEvent extends PlayerEvent {
  final Duration position;
  final Duration duration;
  const PlayerPositionChangedEvent({
    required this.position,
    required this.duration,
  });
  @override
  List<Object?> get props => [position, duration];
}

/// User tapped Skip Intro
class PlayerSkipIntroEvent extends PlayerEvent {
  const PlayerSkipIntroEvent();
}

/// User tapped Next Episode
class PlayerNextEpisodeEvent extends PlayerEvent {
  const PlayerNextEpisodeEvent();
}

/// Save progress and dispose player
class PlayerDisposeEvent extends PlayerEvent {
  const PlayerDisposeEvent();
}