import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final int contentId;
  final String contentType;
  final String title;
  final String tagline;
  final String logoUrl;
  final String backdropUrl;
  final String videoPreviewUrl;
  final List<String> genres;
  final String maturityRating;
  final bool isNetflixOriginal;

  const BannerEntity({
    required this.id,
    required this.contentId,
    required this.contentType,
    required this.title,
    required this.tagline,
    required this.logoUrl,
    required this.backdropUrl,
    required this.videoPreviewUrl,
    required this.genres,
    required this.maturityRating,
    required this.isNetflixOriginal,
  });

  factory BannerEntity.fromJson(Map<String, dynamic> json) {
    return BannerEntity(
      id: json['id']?.toString() ?? '',
      contentId: json['contentId'] as int? ?? 0,
      contentType: json['contentType'] as String? ?? 'movie',
      title: json['title'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      logoUrl: json['logoUrl'] as String? ?? '',
      backdropUrl: json['backdropUrl'] as String? ?? '',
      videoPreviewUrl: json['videoPreviewUrl'] as String? ?? '',
      genres: (json['genres'] as List?)?.map((e) => e.toString()).toList() ?? [],
      maturityRating: json['maturityRating'] as String? ?? '',
      isNetflixOriginal: json['isNetflixOriginal'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        contentId,
        contentType,
        title,
        tagline,
        logoUrl,
        backdropUrl,
        videoPreviewUrl,
        genres,
        maturityRating,
        isNetflixOriginal,
      ];
}
