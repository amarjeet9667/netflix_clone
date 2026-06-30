// lib/features/tv_shows/data/models/episode_model.dart
import '../../domain/entities/episode_entity.dart';

class EpisodeModel extends EpisodeEntity {
  const EpisodeModel({
    required super.id,
    required super.seasonId,
    required super.showId,
    required super.episodeNumber,
    required super.title,
    required super.overview,
    required super.duration,
    required super.stillUrl,
    required super.hasBeenWatched,
    required super.watchProgress,
  });

  factory EpisodeModel.fromDummyMap(Map<String, dynamic> map) {
    return EpisodeModel(
      id: map['id'] as String,
      seasonId: map['seasonId'] as String,
      showId: map['showId'] as int,
      episodeNumber: map['episodeNumber'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String? ?? '',
      duration: map['duration'] as int? ?? 0,
      stillUrl: map['stillUrl'] as String? ?? '',
      hasBeenWatched: map['hasBeenWatched'] as bool? ?? false,
      watchProgress: (map['watchProgress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as String,
      seasonId: json['seasonId'] as String,
      showId: json['showId'] as int,
      episodeNumber: json['episodeNumber'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      stillUrl: json['stillUrl'] as String? ?? '',
      hasBeenWatched: json['hasBeenWatched'] as bool? ?? false,
      watchProgress: (json['watchProgress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  EpisodeModel copyWith({
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
    return EpisodeModel(
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
}
