// lib/shared/enums/quality_enum.dart

/// Download and streaming quality options.
enum DownloadQuality {
  low,
  medium,
  high;

  String get label {
    switch (this) {
      case DownloadQuality.low:    return 'Standard';
      case DownloadQuality.medium: return 'HD';
      case DownloadQuality.high:   return 'Ultra HD';
    }
  }

  String get description {
    switch (this) {
      case DownloadQuality.low:    return 'Uses less storage (~300 MB/hr)';
      case DownloadQuality.medium: return 'Balanced quality (~700 MB/hr)';
      case DownloadQuality.high:   return 'Best quality (~1.4 GB/hr)';
    }
  }
}

/// Streaming quality — separate from download quality
/// because streaming has more tiers (Auto, 4K, etc.)
enum StreamQuality {
  auto,
  low,
  medium,
  high,
  ultra;

  String get label {
    switch (this) {
      case StreamQuality.auto:   return 'Auto';
      case StreamQuality.low:    return 'Low';
      case StreamQuality.medium: return 'Medium';
      case StreamQuality.high:   return 'High';
      case StreamQuality.ultra:  return '4K Ultra HD';
    }
  }
}