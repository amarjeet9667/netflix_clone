// lib/features/player/data/datasources/player_remote_datasource.dart
import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/features/player/data/model/playback_model.dart';
import 'package:netflix_clone/features/player/data/model/subtitle_model.dart';

abstract class PlayerRemoteDataSource {
  Future<PlaybackModel>       getStreamUrl(String contentId);
  Future<List<SubtitleModel>> getSubtitles(String contentId);
  Future<List<String>>        getAvailableQualities(String contentId);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  final ApiClient apiClient;
  const PlayerRemoteDataSourceImpl(this.apiClient);

  @override
  Future<PlaybackModel> getStreamUrl(String contentId) async {
    // ── Test / dev: return a real public video so player works ──
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 300));
      return PlaybackModel.dummy(contentId);
    }

    // ── Prod ──────────────────────────────────────────────────
    try {
      final response = await apiClient.get('/player/$contentId/stream');
      return PlaybackModel.fromJson(
          response as Map<String, dynamic>);
    } on Exception {
      throw ServerException(message: 'Failed to get stream URL.');
    }
  }

  @override
  Future<List<SubtitleModel>> getSubtitles(String contentId) async {
    if (AppConfig.isTest || AppConfig.isDev) {
      await Future.delayed(const Duration(milliseconds: 100));
      return SubtitleModel.defaults;
    }

    try {
      final response = await apiClient.get('/player/$contentId/subtitles');
      return (response as List)
          .map((e) => SubtitleModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      // Non-fatal: subtitles are optional
      return SubtitleModel.defaults;
    }
  }

  @override
  Future<List<String>> getAvailableQualities(String contentId) async {
    return const ['Auto', 'Low', 'Medium', 'High', '4K'];
  }
}