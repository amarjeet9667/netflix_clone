// lib/features/player/presentation/bloc/player_bloc.dart
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_clone/core/constants/app_constants.dart';
import 'package:netflix_clone/features/player/domain/usecases/get_stream_url_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/save_watch_progress_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/get_subtitles_usecase.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final GetStreamUrlUseCase      getStreamUrl;
  final SaveWatchProgressUseCase saveWatchProgress;
  final GetSubtitlesUseCase      getSubtitles;

  Timer? _controlsTimer;
  Timer? _progressTimer;

  PlayerBloc({
    required this.getStreamUrl,
    required this.saveWatchProgress,
    required this.getSubtitles,
  }) : super(const PlayerInitial()) {
    on<PlayerInitEvent>(_onInit);
    on<PlayerTogglePlayPauseEvent>(_onTogglePlayPause);
    on<PlayerSeekEvent>(_onSeek);
    on<PlayerSkipForwardEvent>(_onSkipForward);
    on<PlayerSkipBackwardEvent>(_onSkipBackward);
    on<PlayerToggleMuteEvent>(_onToggleMute);
    on<PlayerSetVolumeEvent>(_onSetVolume);
    on<PlayerSelectSubtitleEvent>(_onSelectSubtitle);
    on<PlayerSelectQualityEvent>(_onSelectQuality);
    on<PlayerToggleControlsEvent>(_onToggleControls);
    on<PlayerPositionChangedEvent>(_onPositionChanged);
    on<PlayerSkipIntroEvent>(_onSkipIntro);
    on<PlayerNextEpisodeEvent>(_onNextEpisode);
    on<PlayerDisposeEvent>(_onDispose);
    on<PlayerAutoHideControlsEvent>(_onAutoHideControls);
  }

  PlayerReady? get _ready =>
      state is PlayerReady ? state as PlayerReady : null;

  // ── Init ──────────────────────────────────────────────────
  Future<void> _onInit(
    PlayerInitEvent    event,
    Emitter<PlayerState> emit,
  ) async {
    emit(const PlayerLoading());

    final result = await getStreamUrl(
      StreamUrlParams(contentId: event.contentId),
    );

    result.fold(
      (failure) => emit(PlayerError(message: failure.message)),
      (url) async {
        // Fetch subtitles in parallel
        final subsResult = await getSubtitles(
          SubtitlesParams(contentId: event.contentId),
        );
        final subs = subsResult.fold(
          (_)    => ['Off', 'English', 'Hindi', 'Spanish'],
          (list) => ['Off', ...list.map((s) => s.language)],
        );
        emit(PlayerReady(
          streamUrl:       url,
          contentId:       event.contentId,
          subtitleOptions: subs,
          isPlaying:       true,
        ));
        _startProgressSaver(event.contentId);
      },
    );
  }

  // ── Play / Pause ──────────────────────────────────────────
  void _onTogglePlayPause(
    PlayerTogglePlayPauseEvent event,
    Emitter<PlayerState>       emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(isPlaying: !r.isPlaying));
    if (!r.isPlaying) _scheduleHideControls();
  }

  // ── Seek ──────────────────────────────────────────────────
  void _onSeek(
    PlayerSeekEvent      event,
    Emitter<PlayerState> emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(position: event.position));
  }

  // ── Skip Forward ──────────────────────────────────────────
  void _onSkipForward(
    PlayerSkipForwardEvent event,
    Emitter<PlayerState>   emit,
  ) {
    final r = _ready;
    if (r == null) return;
    final newPos = r.position + Duration(seconds: event.seconds);
    emit(r.copyWith(
      position: newPos > r.duration ? r.duration : newPos,
    ));
  }

  // ── Skip Backward ─────────────────────────────────────────
  void _onSkipBackward(
    PlayerSkipBackwardEvent event,
    Emitter<PlayerState>    emit,
  ) {
    final r = _ready;
    if (r == null) return;
    final newPos = r.position - Duration(seconds: event.seconds);
    emit(r.copyWith(
      position: newPos < Duration.zero ? Duration.zero : newPos,
    ));
  }

  // ── Mute ──────────────────────────────────────────────────
  void _onToggleMute(
    PlayerToggleMuteEvent event,
    Emitter<PlayerState>  emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(isMuted: !r.isMuted));
  }

  // ── Volume ────────────────────────────────────────────────
  void _onSetVolume(
    PlayerSetVolumeEvent event,
    Emitter<PlayerState> emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(volume: event.volume, isMuted: event.volume == 0));
  }

  // ── Subtitle ──────────────────────────────────────────────
  void _onSelectSubtitle(
    PlayerSelectSubtitleEvent event,
    Emitter<PlayerState>      emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(selectedSubtitle: event.language ?? 'Off'));
  }

  // ── Quality ───────────────────────────────────────────────
  void _onSelectQuality(
    PlayerSelectQualityEvent event,
    Emitter<PlayerState>     emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(selectedQuality: event.quality));
  }

  // ── Controls visibility ───────────────────────────────────
  void _onToggleControls(
    PlayerToggleControlsEvent event,
    Emitter<PlayerState>      emit,
  ) {
    final r = _ready;
    if (r == null) return;
    final show = !r.showControls;
    emit(r.copyWith(showControls: show));
    if (show && r.isPlaying) _scheduleHideControls();
  }

  // ── Position from video controller ────────────────────────
  void _onPositionChanged(
    PlayerPositionChangedEvent event,
    Emitter<PlayerState>       emit,
  ) {
    final r = _ready;
    if (r == null) return;

    final progress = event.duration.inMilliseconds > 0
        ? event.position.inMilliseconds / event.duration.inMilliseconds
        : 0.0;

    // Show skip intro in first 2 minutes
    final showIntro = event.position.inSeconds < 120 &&
                      event.position.inSeconds > 5;
    // Show next episode at 90%
    final showNext  = progress >= AppConstants.autoPlayNextAt;

    emit(r.copyWith(
      position:        event.position,
      duration:        event.duration,
      showSkipIntro:   showIntro,
      showNextEpisode: showNext,
    ));
  }

  // ── Skip Intro ────────────────────────────────────────────
  void _onSkipIntro(
    PlayerSkipIntroEvent event,
    Emitter<PlayerState> emit,
  ) {
    final r = _ready;
    if (r == null) return;
    emit(r.copyWith(
      position:      const Duration(seconds: 120),
      showSkipIntro: false,
    ));
  }

  // ── Next episode ──────────────────────────────────────────
  void _onNextEpisode(
    PlayerNextEpisodeEvent event,
    Emitter<PlayerState>   emit,
  ) {
    // TODO: resolve next episode ID then re-init
    emit(const PlayerInitial());
  }

  // ── Dispose ───────────────────────────────────────────────
  Future<void> _onDispose(
    PlayerDisposeEvent   event,
    Emitter<PlayerState> emit,
  ) async {
    _controlsTimer?.cancel();
    _progressTimer?.cancel();
    final r = _ready;
    if (r != null) {
      await saveWatchProgress(
        SaveProgressParams(
          contentId: r.contentId,
          position:  r.position,
          duration:  r.duration,
        ),
      );
    }
    emit(const PlayerInitial());
  }

  // ── Timers ────────────────────────────────────────────────
  void _scheduleHideControls() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(
      const Duration(seconds: 3),
      () => add(const PlayerAutoHideControlsEvent()),
    );
  }

  void _startProgressSaver(String contentId) {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(
      const Duration(seconds: AppConstants.progressSaveIntervalSecs),
      (_) async {
        final r = _ready;
        if (r == null) return;
        await saveWatchProgress(
          SaveProgressParams(
            contentId: contentId,
            position:  r.position,
            duration:  r.duration,
          ),
        );
      },
    );
  }


  // ── Auto-hide controls (internal timer event) ────────────
  void _onAutoHideControls(
    PlayerAutoHideControlsEvent event,
    Emitter<PlayerState> emit,
  ) {
    final r = _ready;
    if (r != null && r.isPlaying && r.showControls) {
      emit(r.copyWith(showControls: false));
    }
  }

  @override
  Future<void> close() {
    _controlsTimer?.cancel();
    _progressTimer?.cancel();
    return super.close();
  }
}