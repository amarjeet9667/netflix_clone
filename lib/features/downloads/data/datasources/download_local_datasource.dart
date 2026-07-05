// lib/features/downloads/data/datasources/download_local_datasource.dart

import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import '../models/download_model.dart';
import '../../domain/entities/download_entity.dart';

// ── Abstract ─────────────────────────────────────────────────
abstract class DownloadLocalDataSource {
  /// Returns all saved downloads
  Future<List<DownloadModel>> getDownloads();

  /// Persist a new download record
  Future<DownloadModel> saveDownload(DownloadModel download);

  /// Update an existing download record
  Future<DownloadModel> updateDownload(DownloadModel download);

  /// Remove a download record by ID
  Future<void> deleteDownload(String downloadId);

  /// Remove all download records
  Future<void> deleteAllDownloads();

  /// Check if contentId exists in downloads
  Future<bool> isDownloaded(String contentId);
}

// ── Implementation ────────────────────────────────────────────
class DownloadLocalDataSourceImpl implements DownloadLocalDataSource {
  // In-memory store — replace with Hive box in production:
  //   final Box<String> _box = Hive.box(AppConstants.kDownloadsBox);
  final Map<String, DownloadModel> _store = {};

  DownloadLocalDataSourceImpl() {
    _seedFromDummy();
  }

  /// Pre-populate with dummy data so the UI is not empty on first run
  void _seedFromDummy() {
    for (final map in DummyDownloads.downloads) {
      final model = DownloadModel.fromDummyMap(map);
      _store[model.id] = model;
    }
  }

  @override
  Future<List<DownloadModel>> getDownloads() async {
    try {
      return _store.values.toList()
        ..sort((a, b) =>
            (b.downloadedAt ?? DateTime(0))
                .compareTo(a.downloadedAt ?? DateTime(0)));
    } catch (e) {
      throw CacheException('Failed to read downloads: $e');
    }
  }

  @override
  Future<DownloadModel> saveDownload(DownloadModel download) async {
    try {
      _store[download.id] = download;
      // Hive: _box.put(download.id, jsonEncode(download.toJson()));
      return download;
    } catch (e) {
      throw CacheException('Failed to save download: $e');
    }
  }

  @override
  Future<DownloadModel> updateDownload(DownloadModel download) async {
    try {
      if (!_store.containsKey(download.id)) {
        throw CacheException('Download not found: ${download.id}');
      }
      _store[download.id] = download;
      return download;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException('Failed to update download: $e');
    }
  }

  @override
  Future<void> deleteDownload(String downloadId) async {
    try {
      _store.remove(downloadId);
      // Hive: await _box.delete(downloadId);
    } catch (e) {
      throw CacheException('Failed to delete download: $e');
    }
  }

  @override
  Future<void> deleteAllDownloads() async {
    try {
      _store.clear();
      // Hive: await _box.clear();
    } catch (e) {
      throw CacheException('Failed to delete all downloads: $e');
    }
  }

  @override
  Future<bool> isDownloaded(String contentId) async {
    return _store.values.any(
      (d) => d.contentId == contentId &&
             d.status == DownloadStatus.completed,
    );
  }
}