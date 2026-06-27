// lib/shared/enums/sort_order.dart

/// Sort order for content lists.
enum SortOrder {
  newest,
  oldest,
  titleAZ,
  titleZA,
  ratingHigh,
  ratingLow;

  String get label {
    switch (this) {
      case SortOrder.newest:     return 'Newest';
      case SortOrder.oldest:     return 'Oldest';
      case SortOrder.titleAZ:    return 'Title (A–Z)';
      case SortOrder.titleZA:    return 'Title (Z–A)';
      case SortOrder.ratingHigh: return 'Highest Rated';
      case SortOrder.ratingLow:  return 'Lowest Rated';
    }
  }
}