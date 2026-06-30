// lib/features/tv_shows/data/models/season_model.dart
import '../../domain/entities/season_entity.dart';

class SeasonModel extends SeasonEntity {
  const SeasonModel({
    required super.id,
    required super.showId,
    required super.seasonNumber,
    required super.title,
    required super.episodeCount,
    required super.releaseYear,
    required super.overview,
  });

  factory SeasonModel.fromDummyMap(Map<String, dynamic> map) {
    return SeasonModel(
      id: map['id'] as String,
      showId: map['showId'] as int,
      seasonNumber: map['seasonNumber'] as int,
      title: map['title'] as String,
      episodeCount: map['episodeCount'] as int? ?? 0,
      releaseYear: map['releaseYear'] as int? ?? 0,
      overview: map['overview'] as String? ?? '',
    );
  }

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      id: json['id'] as String,
      showId: json['showId'] as int,
      seasonNumber: json['seasonNumber'] as int,
      title: json['title'] as String,
      episodeCount: json['episodeCount'] as int? ?? 0,
      releaseYear: json['releaseYear'] as int? ?? 0,
      overview: json['overview'] as String? ?? '',
    );
  }
}
