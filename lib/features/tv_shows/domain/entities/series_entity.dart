// lib/features/tv_shows/domain/entities/series_entity.dart
import 'package:equatable/equatable.dart';

enum SeriesStatus { ongoing, ended, cancelled }

class SeriesEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final double rating;
  final String maturityRating;
  final int releaseYear;
  final int totalSeasons;
  final int totalEpisodes;
  final List<String> genres;
  final bool isNetflixOriginal;
  final SeriesStatus status;

  const SeriesEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.rating,
    required this.maturityRating,
    required this.releaseYear,
    required this.totalSeasons,
    required this.totalEpisodes,
    required this.genres,
    required this.isNetflixOriginal,
    required this.status,
  });

  int get matchScore => (rating * 10).round();

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterUrl,
    backdropUrl,
    rating,
    maturityRating,
    releaseYear,
    totalSeasons,
    totalEpisodes,
    genres,
    isNetflixOriginal,
    status,
  ];
}
