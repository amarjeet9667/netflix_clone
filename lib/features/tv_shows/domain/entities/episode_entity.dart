import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final String id;
  final String seasonId;
  final int showId;
  final int episodeNumber;
  final String title;
  final String overview;
  final int duration;
  final String stillUrl;
  final bool hasBeenWatched;
  final double watchProgress;

  const EpisodeEntity({
    required this.id,
    required this.seasonId,
    required this.showId,
    required this.episodeNumber,
    required this.title,
    required this.overview,
    required this.duration,
    required this.stillUrl,
    required this.hasBeenWatched,
    required this.watchProgress,
  });

  factory EpisodeEntity.fromJson(Map<String, dynamic> json) {
    return EpisodeEntity(
      id: json['id']?.toString() ?? '',
      seasonId: json['seasonId']?.toString() ?? '',
      showId: json['showId'] as int? ?? 0,
      episodeNumber: json['episodeNumber'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      stillUrl: json['stillUrl'] as String? ?? '',
      hasBeenWatched: json['hasBeenWatched'] as bool? ?? false,
      watchProgress: (json['watchProgress'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        seasonId,
        showId,
        episodeNumber,
        title,
        overview,
        duration,
        stillUrl,
        hasBeenWatched,
        watchProgress,
      ];
}
