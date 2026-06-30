// lib/features/search/data/datasources/search_local_datasource.dart
import 'package:netflix_clone/core/constants/app_constants.dart';
import 'package:netflix_clone/core/errors/exception.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getSearchHistory();
  Future<void> saveSearchQuery(String query);
  Future<void> clearSearchHistory();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  // In-memory store — swap with SharedPreferences:
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.getStringList(AppConstants.kSearchHistoryKey)
  final List<String> _history = [];

  @override
  Future<List<String>> getSearchHistory() async {
    try {
      return List.from(_history);
    } catch (e) {
      throw CacheException('Failed to read search history: $e');
    }
  }

  @override
  Future<void> saveSearchQuery(String query) async {
    try {
      // Remove duplicate, push to front
      _history.remove(query);
      _history.insert(0, query);

      // Cap at AppConstants.maxSearchHistory entries
      if (_history.length > AppConstants.maxSearchHistory) {
        _history.removeRange(AppConstants.maxSearchHistory, _history.length);
      }
    } catch (e) {
      throw CacheException('Failed to save search query: $e');
    }
  }

  @override
  Future<void> clearSearchHistory() async {
    try {
      _history.clear();
    } catch (e) {
      throw CacheException('Failed to clear search history: $e');
    }
  }
}
