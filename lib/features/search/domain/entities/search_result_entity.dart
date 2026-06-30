// lib/features/search/domain/entities/search_result_entity.dart
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';

class SearchResultEntity extends Equatable {
  final String       id;
  final String       title;
  final String       posterUrl;
  final String       backdropUrl;
  final ContentType  contentType;
  final double       rating;
  final int          releaseYear;
  final List<String> genres;
  final String       maturityRating;
  final bool         isNetflixOriginal;

  const SearchResultEntity({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.contentType,
    required this.rating,
    required this.releaseYear,
    required this.genres,
    required this.maturityRating,
    required this.isNetflixOriginal,
  });

  @override
  List<Object?> get props => [
    id, title, posterUrl, backdropUrl, contentType,
    rating, releaseYear, genres, maturityRating, isNetflixOriginal,
  ];
}