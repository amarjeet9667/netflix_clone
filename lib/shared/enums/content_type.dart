// lib/shared/enums/content_type.dart

/// Identifies the type of content across the app.
/// Used in watchlist, downloads, player, and analytics.
enum ContentType {
  movie,
  series,
  episode,
  documentary,
  standup,
  shortFilm;

  String get label {
    switch (this) {
      case ContentType.movie:        return 'Movie';
      case ContentType.series:       return 'TV Series';
      case ContentType.episode:      return 'Episode';
      case ContentType.documentary:  return 'Documentary';
      case ContentType.standup:      return 'Stand-up';
      case ContentType.shortFilm:    return 'Short Film';
    }
  }

  bool get isSeries => this == ContentType.series || this == ContentType.episode;
}