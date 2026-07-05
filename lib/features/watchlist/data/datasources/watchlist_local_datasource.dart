// lib/features/watchlist/data/datasources/watchlist_local_datasource.dart
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import '../models/watchlist_model.dart';

abstract class WatchlistLocalDataSource {
  Future<List<WatchlistModel>> getMyList();
  Future<List<WatchlistModel>> getContinueWatching();
  Future<bool> isAddedToWatchlist(String contentId);
  Future<bool> toggleWatchlist({
    required String contentId,
    required String contentType,
  });
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final List<WatchlistModel> _myList = [];
  final List<WatchlistModel> _continueWatching = [];

  WatchlistLocalDataSourceImpl() {
    _seedFromDummy();
  }

  void _seedFromDummy() {
    for (final map in DummyWatchlist.items) {
      _myList.add(WatchlistModel.fromDummyMap(map));
    }
    for (final map in DummyContinueWatching.items) {
      final contentId = map['contentId']?.toString() ?? '';
      final contentType = map['contentType'] as String? ?? 'movie';
      _continueWatching.add(WatchlistModel(
        id: map['id'] as String? ?? 'cw_${DateTime.now().millisecondsSinceEpoch}',
        contentId: contentId,
        contentType: contentType == 'movie' ? ContentType.movie : ContentType.series,
        addedAt: DateTime.now(),
        title: map['title'] as String?,
        posterUrl: map['thumbnailUrl'] as String?,
        rating: (map['rating'] as num?)?.toDouble() ?? 8.0,
      ));
    }
  }

  @override
  Future<List<WatchlistModel>> getMyList() async {
    return _myList;
  }

  @override
  Future<List<WatchlistModel>> getContinueWatching() async {
    return _continueWatching;
  }

  @override
  Future<bool> isAddedToWatchlist(String contentId) async {
    return _myList.any((item) => item.contentId == contentId);
  }

  @override
  Future<bool> toggleWatchlist({
    required String contentId,
    required String contentType,
  }) async {
    final index = _myList.indexWhere((item) => item.contentId == contentId);
    if (index >= 0) {
      _myList.removeAt(index);
      return false; // Removed
    } else {
      // Find title and posterUrl from dummy data to render correctly in UI
      String? title;
      String? posterUrl;
      double? rating;

      // Try searching movies
      try {
        final movie = DummyMovies.movies.firstWhere((m) => m['id'].toString() == contentId);
        title = movie['title'] as String?;
        posterUrl = movie['posterUrl'] as String?;
        rating = (movie['rating'] as num?)?.toDouble();
      } catch (_) {
        // Try searching tv shows
        try {
          final show = DummyTVShows.shows.firstWhere((s) => s['id'].toString() == contentId);
          title = show['title'] as String?;
          posterUrl = show['posterUrl'] as String?;
          rating = (show['rating'] as num?)?.toDouble();
        } catch (_) {
          title = 'Content $contentId';
          posterUrl = 'https://img.dummyjson.com/product-images/1/1.webp';
          rating = 8.0;
        }
      }

      _myList.add(WatchlistModel(
        id: 'wl_${DateTime.now().millisecondsSinceEpoch}',
        contentId: contentId,
        contentType: contentType == 'movie' ? ContentType.movie : ContentType.series,
        addedAt: DateTime.now(),
        title: title,
        posterUrl: posterUrl,
        rating: rating,
      ));
      return true; // Added
    }
  }
}
