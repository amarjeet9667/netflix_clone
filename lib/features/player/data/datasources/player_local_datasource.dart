// lib/features/player/data/datasources/player_local_datasource.dart
import 'package:netflix_clone/core/errors/exception.dart';
import '../../domain/entities/watch_progress_entity.dart';

abstract class PlayerLocalDataSource {
  Future<WatchProgressEntity?> getProgress(String contentId);
  Future<void>                 saveProgress(WatchProgressEntity progress);
  Future<void>                 deleteProgress(String contentId);
  Future<List<WatchProgressEntity>> getAllProgress();
}

class PlayerLocalDataSourceImpl implements PlayerLocalDataSource {
  // In-memory store — swap with Hive box:
  //   final Box _box = Hive.box(AppConstants.kProgressBox);
  final Map<String, WatchProgressEntity> _store = {};

  @override
  Future<WatchProgressEntity?> getProgress(String contentId) async {
    return _store[contentId];
  }

  @override
  Future<void> saveProgress(WatchProgressEntity progress) async {
    try {
      _store[progress.contentId] = progress;
      // Hive: await _box.put(progress.contentId, _toJson(progress));
    } catch (e) {
      throw CacheException('Failed to save progress: $e');
    }
  }

  @override
  Future<void> deleteProgress(String contentId) async {
    _store.remove(contentId);
  }

  @override
  Future<List<WatchProgressEntity>> getAllProgress() async {
    return _store.values.toList();
  }
}