import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<MovieModel> getMovieDetail(int id);
  Future<List<MovieModel>> getSimilarMovies(int movieId);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient apiClient;
  MovieRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<MovieModel>> getTrendingMovies() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return DummyMovies.movies.map((e) => MovieModel.fromJson(e)).toList();
  }

  @override
  Future<MovieModel> getMovieDetail(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final matching = DummyMovies.movies.firstWhere(
      (m) => m['id'] == id,
      orElse: () => DummyMovies.movies.first,
    );
    return MovieModel.fromJson(matching);
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Filter out target movie, select up to 3 similar genre movies
    final target = DummyMovies.movies.firstWhere(
      (m) => m['id'] == movieId,
      orElse: () => DummyMovies.movies.first,
    );
    final genres = target['genres'] as List? ?? [];
    return DummyMovies.movies
        .where((m) => m['id'] != movieId && (m['genres'] as List).any((g) => genres.contains(g)))
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return DummySearch.search(query).map((e) => MovieModel.fromJson(e)).toList();
  }
}
