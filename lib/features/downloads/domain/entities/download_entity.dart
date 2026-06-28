// lib/features/downloads/domain/entities/download_entity.dart

import 'package:equatable/equatable.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';

enum DownloadStatus {
  queued,
  downloading,
  paused,
  completed,
  failed,
  cancelled,
}

class DownloadEntity extends Equatable {
  final String          id;
  final String          contentId;
  final ContentType     contentType;
  final String          title;
  final String?         episodeLabel;   // e.g. "S1:E3"
  final String          thumbnailUrl;
  final DownloadQuality quality;
  final int?            fileSizeMB;
  final DownloadStatus  status;
  final double          progress;       // 0.0 – 1.0
  final DateTime?       downloadedAt;
  final DateTime?       expiresAt;
  final String?         localPath;      // file path on device after completion

  const DownloadEntity({
    required this.id,
    required this.contentId,
    required this.contentType,
    required this.title,
    this.episodeLabel,
    required this.thumbnailUrl,
    required this.quality,
    this.fileSizeMB,
    required this.status,
    this.progress    = 0.0,
    this.downloadedAt,
    this.expiresAt,
    this.localPath,
  });

  bool get isCompleted   => status == DownloadStatus.completed;
  bool get isDownloading => status == DownloadStatus.downloading;
  bool get isPaused      => status == DownloadStatus.paused;
  bool get isFailed      => status == DownloadStatus.failed;

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  String get sizeLabel {
    if (fileSizeMB == null) return '';
    return fileSizeMB! > 999
        ? '${(fileSizeMB! / 1000).toStringAsFixed(1)} GB'
        : '$fileSizeMB MB';
  }

  DownloadEntity copyWith({
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
    return DownloadEntity(
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

  @override
  List<Object?> get props => [
    id, contentId, contentType, title, episodeLabel,
    thumbnailUrl, quality, fileSizeMB, status,
    progress, downloadedAt, expiresAt, localPath,
  ];
}