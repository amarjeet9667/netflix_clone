// lib/features/watchlist/domain/entities/watchlist_entity.dart
import 'package:equatable/equatable.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';

class WatchlistEntity extends Equatable {
  final String id;
  final String contentId;
  final ContentType contentType;
  final DateTime addedAt;
  
  // Optional content info for UI rendering
  final String? title;
  final String? posterUrl;
  final double? rating;

  const WatchlistEntity({
    required this.id,
    required this.contentId,
    required this.contentType,
    required this.addedAt,
    this.title,
    this.posterUrl,
    this.rating,
  });

  @override
  List<Object?> get props => [id, contentId, contentType, addedAt, title, posterUrl, rating];
}
