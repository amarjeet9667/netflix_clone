import '../models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getCachedMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  MovieLocalDataSourceImpl();

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    // Optional caching implementation
  }

  @override
  Future<List<MovieModel>> getCachedMovies() async {
    return [];
  }
}
