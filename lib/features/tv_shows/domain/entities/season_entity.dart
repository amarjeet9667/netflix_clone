import 'package:equatable/equatable.dart';

class SeasonEntity extends Equatable {
  final String id;
  final int showId;
  final int seasonNumber;
  final String title;
  final int episodeCount;
  final int releaseYear;
  final String overview;

  const SeasonEntity({
    required this.id,
    required this.showId,
    required this.seasonNumber,
    required this.title,
    required this.episodeCount,
    required this.releaseYear,
    required this.overview,
  });

  factory SeasonEntity.fromJson(Map<String, dynamic> json) {
    return SeasonEntity(
      id: json['id']?.toString() ?? '',
      showId: json['showId'] as int? ?? 0,
      seasonNumber: json['seasonNumber'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      episodeCount: json['episodeCount'] as int? ?? 0,
      releaseYear: json['releaseYear'] as int? ?? 0,
      overview: json['overview'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, showId, seasonNumber, title, episodeCount, releaseYear, overview];
}
