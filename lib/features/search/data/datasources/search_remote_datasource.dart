// lib/features/search/data/datasources/search_remote_datasource.dart
import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import '../models/search_result_model.dart';
import '../models/genre_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultModel>> search(String query);
  Future<List<GenreModel>> getGenres();
  Future<List<SearchResultModel>> getByGenre(String genreName);
  Future<List<String>> getTopSearches();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiClient apiClient;
  const SearchRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<SearchResultModel>> search(String query) async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 250));
      final results = DummySearch.search(query);
      return results.map(SearchResultModel.fromDummyMap).toList();
    }

    try {
      final response = await apiClient.get(
        '/search',
        queryParameters: {'q': query},
      );
      return (response['results'] as List)
          .map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Search failed. Please try again.');
    }
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 150));
      return DummyGenres.genres.map(GenreModel.fromDummyMap).toList();
    }

    try {
      final response = await apiClient.get('/genres');
      return (response as List)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load genres.');
    }
  }

  @override
  Future<List<SearchResultModel>> getByGenre(String genreName) async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 250));
      final all = [...DummyMovies.movies, ...DummyTVShows.shows];
      final filtered = all.where((item) {
        final genres = (item['genres'] as List?) ?? [];
        return genres.any(
          (g) => g.toString().toLowerCase() == genreName.toLowerCase(),
        );
      }).toList();
      return filtered.map(SearchResultModel.fromDummyMap).toList();
    }

    try {
      final response = await apiClient.get('/search/genre/$genreName');
      return (response['results'] as List)
          .map((e) => SearchResultModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load genre results.');
    }
  }

  @override
  Future<List<String>> getTopSearches() async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 100));
      // Top search terms derived from trending titles
      return DummyMovies.trending
          .take(8)
          .map((m) => m['title'] as String)
          .toList();
    }

    try {
      final response = await apiClient.get('/search/trending');
      return (response as List).map((e) => e.toString()).toList();
    } on Exception {
      return const [];
    }
  }
}
