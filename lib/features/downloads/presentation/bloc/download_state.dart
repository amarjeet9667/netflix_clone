// lib/features/downloads/presentation/bloc/download_state.dart
part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();
  @override
  List<Object?> get props => [];
}

class DownloadInitial extends DownloadState {
  const DownloadInitial();
}

class DownloadLoading extends DownloadState {
  const DownloadLoading();
}

class DownloadListLoaded extends DownloadState {
  final List<DownloadEntity> completed;
  final List<DownloadEntity> inProgress;
  const DownloadListLoaded({
    required this.completed,
    required this.inProgress,
  });

  /// Total bytes across completed downloads
  int get totalSizeMB => completed.fold(
    0, (sum, d) => sum + (d.fileSizeMB ?? 0),
  );

  @override
  List<Object?> get props => [completed, inProgress];
}

/// A download just started
class DownloadStarted extends DownloadState {
  final DownloadEntity       download;
  final List<DownloadEntity> completed;
  final List<DownloadEntity> inProgress;
  const DownloadStarted({
    required this.download,
    required this.completed,
    required this.inProgress,
  });
  @override
  List<Object?> get props => [download, completed, inProgress];
}

/// Progress updated for an ongoing download
class DownloadProgressUpdated extends DownloadState {
  final List<DownloadEntity> completed;
  final List<DownloadEntity> inProgress;
  const DownloadProgressUpdated({
    required this.completed,
    required this.inProgress,
  });
  @override
  List<Object?> get props => [completed, inProgress];
}

/// A download completed successfully
class DownloadCompleted extends DownloadState {
  final DownloadEntity       download;
  final List<DownloadEntity> completed;
  final List<DownloadEntity> inProgress;
  const DownloadCompleted({
    required this.download,
    required this.completed,
    required this.inProgress,
  });
  @override
  List<Object?> get props => [download, completed, inProgress];
}

class DownloadError extends DownloadState {
  final String message;
  const DownloadError({required this.message});
  @override
  List<Object?> get props => [message];
}