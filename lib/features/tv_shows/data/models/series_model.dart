// lib/features/tv_shows/data/models/series_model.dart
import '../../domain/entities/series_entity.dart';

class SeriesModel extends SeriesEntity {
  const SeriesModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.backdropUrl,
    required super.rating,
    required super.maturityRating,
    required super.releaseYear,
    required super.totalSeasons,
    required super.totalEpisodes,
    required super.genres,
    required super.isNetflixOriginal,
    required super.status,
  });

  factory SeriesModel.fromDummyMap(Map<String, dynamic> map) {
    return SeriesModel(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String? ?? '',
      posterUrl: map['posterUrl'] as String? ?? '',
      backdropUrl: map['backdropUrl'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      maturityRating: map['maturityRating'] as String? ?? '',
      releaseYear: map['releaseYear'] as int? ?? 0,
      totalSeasons: map['totalSeasons'] as int? ?? 1,
      totalEpisodes: map['totalEpisodes'] as int? ?? 0,
      genres: (map['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      isNetflixOriginal: map['isNetflixOriginal'] as bool? ?? false,
      status: _parseStatus(map['status'] as String?),
    );
  }

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      posterUrl: json['posterUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      maturityRating: json['maturityRating'] as String? ?? '',
      releaseYear: json['releaseYear'] as int? ?? 0,
      totalSeasons: json['totalSeasons'] as int? ?? 1,
      totalEpisodes: json['totalEpisodes'] as int? ?? 0,
      genres:
          (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      isNetflixOriginal: json['isNetflixOriginal'] as bool? ?? false,
      status: _parseStatus(json['status'] as String?),
    );
  }

  static SeriesStatus _parseStatus(String? raw) {
    switch (raw) {
      case 'Ongoing':
        return SeriesStatus.ongoing;
      case 'Cancelled':
        return SeriesStatus.cancelled;
      case 'Ended':
      default:
        return SeriesStatus.ended;
    }
  }
}
