import 'package:equatable/equatable.dart';

class TVShowEntity extends Equatable {
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
  final String status;

  const TVShowEntity({
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

  factory TVShowEntity.fromJson(Map<String, dynamic> json) {
    return TVShowEntity(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterUrl: json['posterUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      maturityRating: json['maturityRating'] as String? ?? '',
      releaseYear: json['releaseYear'] as int? ?? 0,
      totalSeasons: json['totalSeasons'] as int? ?? 0,
      totalEpisodes: json['totalEpisodes'] as int? ?? 0,
      genres: (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      isNetflixOriginal: json['isNetflixOriginal'] as bool? ?? false,
      status: json['status'] as String? ?? '',
    );
  }

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
