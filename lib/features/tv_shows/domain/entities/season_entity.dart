// lib/features/tv_shows/domain/entities/season_entity.dart
import 'package:equatable/equatable.dart';

class SeasonEntity extends Equatable {
  final String id;
  final int    showId;
  final int    seasonNumber;
  final String title;
  final int    episodeCount;
  final int    releaseYear;
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

  @override
  List<Object?> get props =>
      [id, showId, seasonNumber, title, episodeCount, releaseYear, overview];
}