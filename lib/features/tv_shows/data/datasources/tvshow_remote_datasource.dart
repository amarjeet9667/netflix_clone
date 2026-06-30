// lib/features/tv_shows/data/datasources/tvshow_remote_datasource.dart
import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import '../models/series_model.dart';
import '../models/season_model.dart';
import '../models/episode_model.dart';

abstract class TVShowRemoteDataSource {
  Future<List<SeriesModel>> getTVShows();
  Future<SeriesModel> getShowDetail(int showId);
  Future<List<SeriesModel>> getTrendingShows();
  Future<List<SeriesModel>> getNetflixOriginals();
  Future<List<SeriesModel>> getShowsByGenre(String genre);
  Future<List<SeriesModel>> getSimilarShows(int showId);
  Future<List<SeasonModel>> getSeasons(int showId);
  Future<List<EpisodeModel>> getEpisodes({
    required int showId,
    required int seasonNumber,
  });
  Future<EpisodeModel> getEpisodeDetail({
    required int showId,
    required int seasonNumber,
    required int episodeNumber,
  });
}

class TVShowRemoteDataSourceImpl implements TVShowRemoteDataSource {
  final ApiClient apiClient;
  const TVShowRemoteDataSourceImpl(this.apiClient);

  bool get _useDummy => AppConfig.isTest || AppConfig.isDev;

  @override
  Future<List<SeriesModel>> getTVShows() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 250));
      return DummyTVShows.shows.map(SeriesModel.fromDummyMap).toList();
    }
    try {
      final response = await apiClient.get('/tv');
      return (response['shows'] as List)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load TV shows.');
    }
  }

  @override
  Future<SeriesModel> getShowDetail(int showId) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      final map = DummyTVShows.shows.firstWhere(
        (s) => s['id'] == showId,
        orElse: () => DummyTVShows.shows.first,
      );
      return SeriesModel.fromDummyMap(map);
    }
    try {
      final response = await apiClient.get('/tv/$showId');
      return SeriesModel.fromJson(response as Map<String, dynamic>);
    } on Exception {
      throw NotFoundException('Show not found.');
    }
  }

  @override
  Future<List<SeriesModel>> getTrendingShows() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      // First 2 shows treated as "trending" in dummy data
      return DummyTVShows.shows.take(2).map(SeriesModel.fromDummyMap).toList();
    }
    try {
      final response = await apiClient.get('/tv/trending');
      return (response['shows'] as List)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load trending shows.');
    }
  }

  @override
  Future<List<SeriesModel>> getNetflixOriginals() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyTVShows.shows
          .where((s) => s['isNetflixOriginal'] == true)
          .map(SeriesModel.fromDummyMap)
          .toList();
    }
    try {
      final response = await apiClient.get('/tv/originals');
      return (response['shows'] as List)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load originals.');
    }
  }

  @override
  Future<List<SeriesModel>> getShowsByGenre(String genre) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyTVShows.shows
          .where(
            (s) => (s['genres'] as List).any(
              (g) => g.toString().toLowerCase() == genre.toLowerCase(),
            ),
          )
          .map(SeriesModel.fromDummyMap)
          .toList();
    }
    try {
      final response = await apiClient.get('/tv/genre/$genre');
      return (response['shows'] as List)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load genre shows.');
    }
  }

  @override
  Future<List<SeriesModel>> getSimilarShows(int showId) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyTVShows.shows
          .where((s) => s['id'] != showId)
          .map(SeriesModel.fromDummyMap)
          .toList();
    }
    try {
      final response = await apiClient.get('/tv/$showId/similar');
      return (response['shows'] as List)
          .map((e) => SeriesModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<List<SeasonModel>> getSeasons(int showId) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 150));
      return DummyTVShows.seasons
          .where((s) => s['showId'] == showId)
          .map(SeasonModel.fromDummyMap)
          .toList();
    }
    try {
      final response = await apiClient.get('/tv/$showId/seasons');
      return (response['seasons'] as List)
          .map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load seasons.');
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodes({
    required int showId,
    required int seasonNumber,
  }) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      final season = DummyTVShows.seasons.firstWhere(
        (s) => s['showId'] == showId && s['seasonNumber'] == seasonNumber,
        orElse: () => DummyTVShows.seasons.first,
      );
      return DummyTVShows.episodes
          .where((e) => e['seasonId'] == season['id'])
          .map(EpisodeModel.fromDummyMap)
          .toList();
    }
    try {
      final response = await apiClient.get(
        '/tv/$showId/seasons/$seasonNumber/episodes',
      );
      return (response['episodes'] as List)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load episodes.');
    }
  }

  @override
  Future<EpisodeModel> getEpisodeDetail({
    required int showId,
    required int seasonNumber,
    required int episodeNumber,
  }) async {
    final episodes = await getEpisodes(
      showId: showId,
      seasonNumber: seasonNumber,
    );
    return episodes.firstWhere(
      (e) => e.episodeNumber == episodeNumber,
      orElse: () => episodes.first,
    );
  }
}
