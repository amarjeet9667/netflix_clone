import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import '../../domain/entities/tvshow_entity.dart';
import '../../domain/entities/season_entity.dart';
import '../../domain/entities/episode_entity.dart';

abstract class TVShowRemoteDataSource {
  Future<List<TVShowEntity>> getTVShows();
  Future<SeasonEntity> getSeasonDetail(int showId, int seasonNumber);
  Future<List<EpisodeEntity>> getEpisodes(int showId, int seasonNumber);
}

class TVShowRemoteDataSourceImpl implements TVShowRemoteDataSource {
  final ApiClient apiClient;
  TVShowRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<TVShowEntity>> getTVShows() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return DummyTVShows.shows.map((e) => TVShowEntity.fromJson(e)).toList();
  }

  @override
  Future<SeasonEntity> getSeasonDetail(int showId, int seasonNumber) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final matching = DummyTVShows.seasons.firstWhere(
      (s) => s['showId'] == showId && s['seasonNumber'] == seasonNumber,
      orElse: () => DummyTVShows.seasons.first,
    );
    return SeasonEntity.fromJson(matching);
  }

  @override
  Future<List<EpisodeEntity>> getEpisodes(int showId, int seasonNumber) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return DummyTVShows.episodes
        .where((e) => e['showId'] == showId)
        .map((e) => EpisodeEntity.fromJson(e))
        .toList();
  }
}
