import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final String trailerUrl;
  final double rating;
  final String maturityRating;
  final int releaseYear;
  final int duration;
  final List<String> genres;
  final List<String> cast;
  final String director;
  final bool isNetflixOriginal;
  final bool isTrending;
  final bool isTopTen;
  final int? rank;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.trailerUrl,
    required this.rating,
    required this.maturityRating,
    required this.releaseYear,
    required this.duration,
    required this.genres,
    required this.cast,
    required this.director,
    required this.isNetflixOriginal,
    required this.isTrending,
    required this.isTopTen,
    this.rank,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterUrl,
        backdropUrl,
        trailerUrl,
        rating,
        maturityRating,
        releaseYear,
        duration,
        genres,
        cast,
        director,
        isNetflixOriginal,
        isTrending,
        isTopTen,
        rank,
      ];
}
