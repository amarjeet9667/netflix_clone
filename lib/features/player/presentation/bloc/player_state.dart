// lib/features/player/presentation/bloc/player_state.dart
part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();
  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial();
}

/// Fetching stream URL
class PlayerLoading extends PlayerState {
  const PlayerLoading();
}

/// Stream URL ready — video controller can be initialised
class PlayerReady extends PlayerState {
  final String    streamUrl;
  final String    contentId;
  final Duration  duration;
  final Duration  position;
  final bool      isPlaying;
  final bool      isMuted;
  final double    volume;
  final bool      showControls;
  final String?   selectedSubtitle;
  final String    selectedQuality;
  final bool      showSkipIntro;
  final bool      showNextEpisode;
  final List<String> subtitleOptions;

  const PlayerReady({
    required this.streamUrl,
    required this.contentId,
    this.duration        = Duration.zero,
    this.position        = Duration.zero,
    this.isPlaying       = false,
    this.isMuted         = false,
    this.volume          = 1.0,
    this.showControls    = true,
    this.selectedSubtitle,
    this.selectedQuality = 'Auto',
    this.showSkipIntro   = false,
    this.showNextEpisode = false,
    this.subtitleOptions = const ['Off', 'English', 'Hindi', 'Spanish'],
  });

  double get progress => duration.inMilliseconds > 0
      ? position.inMilliseconds / duration.inMilliseconds
      : 0.0;

  String get positionLabel => _format(position);
  String get durationLabel => _format(duration);

  String _format(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  PlayerReady copyWith({
    String?    streamUrl,
    String?    contentId,
    Duration?  duration,
    Duration?  position,
    bool?      isPlaying,
    bool?      isMuted,
    double?    volume,
    bool?      showControls,
    String?    selectedSubtitle,
    String?    selectedQuality,
    bool?      showSkipIntro,
    bool?      showNextEpisode,
    List<String>? subtitleOptions,
  }) {
    return PlayerReady(
      streamUrl:       streamUrl       ?? this.streamUrl,
      contentId:       contentId       ?? this.contentId,
      duration:        duration        ?? this.duration,
      position:        position        ?? this.position,
      isPlaying:       isPlaying       ?? this.isPlaying,
      isMuted:         isMuted         ?? this.isMuted,
      volume:          volume          ?? this.volume,
      showControls:    showControls    ?? this.showControls,
      selectedSubtitle: selectedSubtitle ?? this.selectedSubtitle,
      selectedQuality: selectedQuality ?? this.selectedQuality,
      showSkipIntro:   showSkipIntro   ?? this.showSkipIntro,
      showNextEpisode: showNextEpisode ?? this.showNextEpisode,
      subtitleOptions: subtitleOptions ?? this.subtitleOptions,
    );
  }

  @override
  List<Object?> get props => [
    streamUrl, contentId, duration, position,
    isPlaying, isMuted, volume, showControls,
    selectedSubtitle, selectedQuality,
    showSkipIntro, showNextEpisode,
  ];
}

class PlayerError extends PlayerState {
  final String message;
  const PlayerError({required this.message});
  @override
  List<Object?> get props => [message];
}