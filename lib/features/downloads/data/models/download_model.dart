// lib/features/downloads/data/models/download_model.dart

import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';
import '../../domain/entities/download_entity.dart';

class DownloadModel extends DownloadEntity {
  const DownloadModel({
    required super.id,
    required super.contentId,
    required super.contentType,
    required super.title,
    super.episodeLabel,
    required super.thumbnailUrl,
    required super.quality,
    super.fileSizeMB,
    required super.status,
    super.progress,
    super.downloadedAt,
    super.expiresAt,
    super.localPath,
  });

  // ── From Hive/JSON local storage ──────────────────────────
  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(
      id:           json['id'] as String,
      contentId:    json['contentId'] as String,
      contentType:  ContentType.values.firstWhere(
        (e) => e.name == json['contentType'],
        orElse: () => ContentType.movie,
      ),
      title:        json['title'] as String,
      episodeLabel: json['episodeLabel'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String,
      quality: DownloadQuality.values.firstWhere(
        (e) => e.name == json['quality'],
        orElse: () => DownloadQuality.medium,
      ),
      fileSizeMB:   json['fileSizeMB'] as int?,
      status: DownloadStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => DownloadStatus.queued,
      ),
      progress:     (json['progress'] as num?)?.toDouble() ?? 0.0,
      downloadedAt: json['downloadedAt'] != null
          ? DateTime.parse(json['downloadedAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
      localPath:    json['localPath'] as String?,
    );
  }

  // ── From dummy data map ───────────────────────────────────
  factory DownloadModel.fromDummyMap(Map<String, dynamic> map) {
    return DownloadModel(
      id:           map['id'] as String,
      contentId:    map['contentId'].toString(),
      contentType:  map['contentType'] == 'series'
                        ? ContentType.series
                        : ContentType.movie,
      title:        map['title'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      quality:      map['quality'] == 'HD'
                        ? DownloadQuality.high
                        : DownloadQuality.medium,
      fileSizeMB:   map['fileSizeMB'] as int?,
      status:       map['status'] == 'completed'
                        ? DownloadStatus.completed
                        : DownloadStatus.downloading,
      progress:     (map['progressPercent'] as double?) ?? 1.0,
      downloadedAt: map['downloadedAt'] != null
          ? DateTime.tryParse(map['downloadedAt'] as String)
          : null,
      expiresAt: map['expiresAt'] != null
          ? DateTime.tryParse(map['expiresAt'] as String)
          : null,
    );
  }

  // ── To JSON for local storage ─────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'id':           id,
      'contentId':    contentId,
      'contentType':  contentType.name,
      'title':        title,
      'episodeLabel': episodeLabel,
      'thumbnailUrl': thumbnailUrl,
      'quality':      quality.name,
      'fileSizeMB':   fileSizeMB,
      'status':       status.name,
      'progress':     progress,
      'downloadedAt': downloadedAt?.toIso8601String(),
      'expiresAt':    expiresAt?.toIso8601String(),
      'localPath':    localPath,
    };
  }

  // ── Convert entity → model ────────────────────────────────
  factory DownloadModel.fromEntity(DownloadEntity entity) {
    return DownloadModel(
      id:           entity.id,
      contentId:    entity.contentId,
      contentType:  entity.contentType,
      title:        entity.title,
      episodeLabel: entity.episodeLabel,
      thumbnailUrl: entity.thumbnailUrl,
      quality:      entity.quality,
      fileSizeMB:   entity.fileSizeMB,
      status:       entity.status,
      progress:     entity.progress,
      downloadedAt: entity.downloadedAt,
      expiresAt:    entity.expiresAt,
      localPath:    entity.localPath,
    );
  }

  @override
  DownloadModel copyWith({
    String?          id,
    String?          contentId,
    ContentType?     contentType,
    String?          title,
    String?          episodeLabel,
    String?          thumbnailUrl,
    DownloadQuality? quality,
    int?             fileSizeMB,
    DownloadStatus?  status,
    double?          progress,
    DateTime?        downloadedAt,
    DateTime?        expiresAt,
    String?          localPath,
  }) {
    return DownloadModel(
      id:           id           ?? this.id,
      contentId:    contentId    ?? this.contentId,
      contentType:  contentType  ?? this.contentType,
      title:        title        ?? this.title,
      episodeLabel: episodeLabel ?? this.episodeLabel,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      quality:      quality      ?? this.quality,
      fileSizeMB:   fileSizeMB   ?? this.fileSizeMB,
      status:       status       ?? this.status,
      progress:     progress     ?? this.progress,
      downloadedAt: downloadedAt ?? this.downloadedAt,
      expiresAt:    expiresAt    ?? this.expiresAt,
      localPath:    localPath    ?? this.localPath,
    );
  }
}