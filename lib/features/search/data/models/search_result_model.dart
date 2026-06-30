// lib/features/search/data/models/search_result_model.dart
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../../domain/entities/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.contentType,
    required super.rating,
    required super.releaseYear,
    required super.genres,
    required super.maturityRating,
    required super.isNetflixOriginal,
  });

  /// Build from DummyMovies / DummyTVShows map shape
  /// (both share enough common keys to use one factory)
  factory SearchResultModel.fromDummyMap(Map<String, dynamic> map) {
    final isShow = map.containsKey('totalSeasons');
    return SearchResultModel(
      id: map['id'].toString(),
      title: map['title'] as String,
      posterUrl: map['posterUrl'] as String? ?? '',
      backdropUrl: map['backdropUrl'] as String? ?? '',
      contentType: isShow ? ContentType.series : ContentType.movie,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      releaseYear: map['releaseYear'] as int? ?? 0,
      genres: (map['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      maturityRating: map['maturityRating'] as String? ?? '',
      isNetflixOriginal: map['isNetflixOriginal'] as bool? ?? false,
    );
  }

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      contentType: ContentType.values.firstWhere(
        (e) => e.name == json['contentType'],
        orElse: () => ContentType.movie,
      ),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      releaseYear: json['releaseYear'] as int? ?? 0,
      genres:
          (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      maturityRating: json['maturityRating'] as String? ?? '',
      isNetflixOriginal: json['isNetflixOriginal'] as bool? ?? false,
    );
  }
}
