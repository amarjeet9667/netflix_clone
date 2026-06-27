// lib/features/downloads/presentation/bloc/download_bloc.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/features/downloads/domain/entities/download_entity.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/start_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/cancel_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/get_downloads_usecase.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';
import 'package:netflix_clone/shared/enums/quality_enum.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final StartDownloadUseCase  startDownload;
  final CancelDownloadUseCase cancelDownload;
  final GetDownloadsUseCase   getDownloads;

  DownloadBloc({
    required this.startDownload,
    required this.cancelDownload,
    required this.getDownloads,
  }) : super(const DownloadInitial()) {
    on<DownloadFetchAllEvent>(_onFetchAll);
    on<DownloadStartEvent>(_onStart);
    on<DownloadProgressEvent>(_onProgress);
    on<DownloadCancelEvent>(_onCancel);
    on<DownloadDeleteEvent>(_onDelete);
    on<DownloadDeleteAllEvent>(_onDeleteAll);
  }

  // ── Helpers to extract lists from current state ───────────
  List<DownloadEntity> get _completed {
    if (state is DownloadListLoaded)
      return (state as DownloadListLoaded).completed;
    if (state is DownloadProgressUpdated)
      return (state as DownloadProgressUpdated).completed;
    if (state is DownloadCompleted)
      return (state as DownloadCompleted).completed;
    return [];
  }

  List<DownloadEntity> get _inProgress {
    if (state is DownloadListLoaded)
      return (state as DownloadListLoaded).inProgress;
    if (state is DownloadProgressUpdated)
      return (state as DownloadProgressUpdated).inProgress;
    if (state is DownloadCompleted)
      return (state as DownloadCompleted).inProgress;
    return [];
  }

  // ── Fetch all ─────────────────────────────────────────────
  Future<void> _onFetchAll(
    DownloadFetchAllEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadLoading());
    final result = await getDownloads();
    result.fold(
      (failure) => emit(DownloadError(message: failure.message)),
      (downloads) {
        final completed   = downloads
            .where((d) => d.status == DownloadStatus.completed)
            .toList();
        final inProgress  = downloads
            .where((d) => d.status == DownloadStatus.downloading)
            .toList();
        emit(DownloadListLoaded(
          completed:  completed,
          inProgress: inProgress,
        ));
      },
    );
  }

  // ── Start a download ──────────────────────────────────────
  Future<void> _onStart(
    DownloadStartEvent event,
    Emitter<DownloadState> emit,
  ) async {
    final result = await startDownload(
      StartDownloadParams(
        contentId:    event.contentId,
        contentType:  event.contentType,
        quality:      event.quality, 
        title: event.title, 
        thumbnailUrl: event.thumbnailUrl,
      ),
    );
    result.fold(
      (failure) => emit(DownloadError(message: failure.message)),
      (download) => emit(DownloadStarted(
        download:   download,
        completed:  _completed,
        inProgress: [..._inProgress, download],
      )),
    );
  }

  // ── Progress update ───────────────────────────────────────
  void _onProgress(
    DownloadProgressEvent event,
    Emitter<DownloadState> emit,
  ) {
    final updated = _inProgress.map((d) {
      if (d.contentId != event.contentId) return d;
      final done = event.progress >= 1.0;
      return d.copyWith(
        progress: event.progress,
        status:   done ? DownloadStatus.completed : DownloadStatus.downloading,
      );
    }).toList();

    final nowDone = updated
        .where((d) => d.status == DownloadStatus.completed)
        .toList();
    final stillGoing = updated
        .where((d) => d.status == DownloadStatus.downloading)
        .toList();

    if (nowDone.isNotEmpty) {
      emit(DownloadCompleted(
        download:   nowDone.first,
        completed:  [..._completed, ...nowDone],
        inProgress: stillGoing,
      ));
    } else {
      emit(DownloadProgressUpdated(
        completed:  _completed,
        inProgress: updated,
      ));
    }
  }

  // ── Cancel ────────────────────────────────────────────────
  Future<void> _onCancel(
    DownloadCancelEvent event,
    Emitter<DownloadState> emit,
  ) async {
    final result = await cancelDownload(
      CancelDownloadParams(contentId: event.contentId),
    );
    result.fold(
      (failure) => emit(DownloadError(message: failure.message)),
      (_) => emit(DownloadListLoaded(
        completed:  _completed,
        inProgress: _inProgress
            .where((d) => d.contentId != event.contentId)
            .toList(),
      )),
    );
  }

  // ── Delete ────────────────────────────────────────────────
  Future<void> _onDelete(
    DownloadDeleteEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(DownloadListLoaded(
      completed:  _completed
          .where((d) => d.id != event.downloadId)
          .toList(),
      inProgress: _inProgress,
    ));
  }

  // ── Delete all ────────────────────────────────────────────
  Future<void> _onDeleteAll(
    DownloadDeleteAllEvent event,
    Emitter<DownloadState> emit,
  ) async {
    emit(const DownloadListLoaded(completed: [], inProgress: []));
  }
}