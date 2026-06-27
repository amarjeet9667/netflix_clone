// lib/features/downloads/presentation/bloc/download_event.dart
part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();
  @override
  List<Object?> get props => [];
}

/// Load all downloaded items from local storage
class DownloadFetchAllEvent extends DownloadEvent {
  const DownloadFetchAllEvent();
}

/// Start a new download
class DownloadStartEvent extends DownloadEvent {
  final String         contentId;
  final ContentType    contentType;
  final String         title;
  final String         thumbnailUrl;
  final DownloadQuality quality;
  const DownloadStartEvent({
    required this.contentId,
    required this.contentType,
    required this.title,
    required this.thumbnailUrl,
    required this.quality,
  });
  @override
  List<Object?> get props => [contentId, contentType, quality];
}

/// Update progress of an ongoing download (emitted by background task)
class DownloadProgressEvent extends DownloadEvent {
  final String contentId;
  final double progress; // 0.0 – 1.0
  const DownloadProgressEvent({
    required this.contentId,
    required this.progress,
  });
  @override
  List<Object?> get props => [contentId, progress];
}

/// Cancel an in-progress download
class DownloadCancelEvent extends DownloadEvent {
  final String contentId;
  const DownloadCancelEvent({required this.contentId});
  @override
  List<Object?> get props => [contentId];
}

/// Delete a completed download from device
class DownloadDeleteEvent extends DownloadEvent {
  final String downloadId;
  const DownloadDeleteEvent({required this.downloadId});
  @override
  List<Object?> get props => [downloadId];
}

/// Delete all downloads
class DownloadDeleteAllEvent extends DownloadEvent {
  const DownloadDeleteAllEvent();
}