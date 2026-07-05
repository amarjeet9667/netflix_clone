// lib/features/watchlist/data/models/watchlist_model.dart
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../../domain/entities/watchlist_entity.dart';

class WatchlistModel extends WatchlistEntity {
  const WatchlistModel({
    required super.id,
    required super.contentId,
    required super.contentType,
    required super.addedAt,
    super.title,
    super.posterUrl,
    super.rating,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) {
    return WatchlistModel(
      id: json['id'] as String,
      contentId: (json['contentId'] ?? json['content']?['id']?.toString()) as String,
      contentType: ContentType.values.firstWhere(
        (e) => e.name == (json['contentType'] ?? json['content']?['contentType'] as String),
        orElse: () => ContentType.movie,
      ),
      addedAt: DateTime.parse(json['addedAt'] as String),
      title: json['title'] ?? json['content']?['title'] as String?,
      posterUrl: json['posterUrl'] ?? json['content']?['posterUrl'] as String?,
      rating: (json['rating'] ?? json['content']?['rating'] as num?)?.toDouble(),
    );
  }

  factory WatchlistModel.fromDummyMap(Map<String, dynamic> map) {
    final content = map['content'] as Map<String, dynamic>?;
    return WatchlistModel(
      id: map['id'] as String,
      contentId: (content?['id'] ?? map['contentId'])?.toString() ?? '',
      contentType: (content?['contentType'] as String? ?? map['contentType'] as String? ?? 'movie') == 'movie'
          ? ContentType.movie
          : ContentType.series,
      addedAt: DateTime.parse(map['addedAt'] as String? ?? DateTime.now().toIso8601String()),
      title: content?['title'] as String?,
      posterUrl: content?['posterUrl'] as String?,
      rating: (content?['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'contentId': contentId,
    'contentType': contentType.name,
    'addedAt': addedAt.toIso8601String(),
    'title': title,
    'posterUrl': posterUrl,
    'rating': rating,
  };
}
