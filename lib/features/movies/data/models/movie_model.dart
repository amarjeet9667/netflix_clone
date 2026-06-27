import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.backdropUrl,
    required super.trailerUrl,
    required super.rating,
    required super.maturityRating,
    required super.releaseYear,
    required super.duration,
    required super.genres,
    required super.cast,
    required super.director,
    required super.isNetflixOriginal,
    required super.isTrending,
    required super.isTopTen,
    super.rank,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      posterUrl: json['posterUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      trailerUrl: json['trailerUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      maturityRating: json['maturityRating'] as String? ?? '',
      releaseYear: json['releaseYear'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
      genres: (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      cast: (json['cast'] as List?)?.map((e) => e.toString()).toList() ?? [],
      director: json['director'] as String? ?? '',
      isNetflixOriginal: json['isNetflixOriginal'] as bool? ?? false,
      isTrending: json['isTrending'] as bool? ?? false,
      isTopTen: json['isTopTen'] as bool? ?? false,
      rank: json['rank'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterUrl': posterUrl,
      'backdropUrl': backdropUrl,
      'trailerUrl': trailerUrl,
      'rating': rating,
      'maturityRating': maturityRating,
      'releaseYear': releaseYear,
      'duration': duration,
      'genres': genres,
      'cast': cast,
      'director': director,
      'isNetflixOriginal': isNetflixOriginal,
      'isTrending': isTrending,
      'isTopTen': isTopTen,
      'rank': rank,
    };
  }
}
