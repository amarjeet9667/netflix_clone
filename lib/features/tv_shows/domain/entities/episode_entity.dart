// lib/features/tv_shows/domain/entities/episode_entity.dart
import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final String id;
  final String seasonId;
  final int showId;
  final int episodeNumber;
  final String title;
  final String overview;
  final int duration; // minutes
  final String stillUrl;
  final bool hasBeenWatched;
  final double watchProgress; // 0.0 – 1.0

  const EpisodeEntity({
    required this.id,
    required this.seasonId,
    required this.showId,
    required this.episodeNumber,
    required this.title,
    required this.overview,
    required this.duration,
    required this.stillUrl,
    required this.hasBeenWatched,
    required this.watchProgress,
  });

  bool get isInProgress =>
      hasBeenWatched && watchProgress > 0 && watchProgress < 1.0;

  String get durationLabel => '${duration}m';

  EpisodeEntity copyWith({
    String? id,
    String? seasonId,
    int? showId,
    int? episodeNumber,
    String? title,
    String? overview,
    int? duration,
    String? stillUrl,
    bool? hasBeenWatched,
    double? watchProgress,
  }) {
    return EpisodeEntity(
      id: id ?? this.id,
      seasonId: seasonId ?? this.seasonId,
      showId: showId ?? this.showId,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      duration: duration ?? this.duration,
      stillUrl: stillUrl ?? this.stillUrl,
      hasBeenWatched: hasBeenWatched ?? this.hasBeenWatched,
      watchProgress: watchProgress ?? this.watchProgress,
    );
  }

  @override
  List<Object?> get props => [
    id,
    seasonId,
    showId,
    episodeNumber,
    title,
    overview,
    duration,
    stillUrl,
    hasBeenWatched,
    watchProgress,
  ];
}
