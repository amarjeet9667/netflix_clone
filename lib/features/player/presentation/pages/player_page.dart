// lib/features/player/presentation/pages/player_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import '../bloc/player_bloc.dart';

class PlayerPage extends StatefulWidget {
  final String contentId;
  const PlayerPage({super.key, required this.contentId});
  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    super.initState();
    // Force landscape + immersive
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // ✅ Fixed: init via BLoC instead of local state
    context.read<PlayerBloc>().add(PlayerInitEvent(
      contentId:   widget.contentId,
      contentType: 'movie',
    ));
  }

  @override
  void dispose() {
    // ✅ Fixed: save progress + reset via BLoC
    context.read<PlayerBloc>().add(const PlayerDisposeEvent());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {

          // ── Loading ──────────────────────────────────────
          if (state is PlayerLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.textPrimary,
              ),
            );
          }

          // ── Error ─────────────────────────────────────────
          if (state is PlayerError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.error, size: 56),
                  const SizedBox(height: AppSizes.spaceMD),
                  Text(state.message,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center),
                  const SizedBox(height: AppSizes.spaceMD),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.netflixRed),
                    onPressed: () => context.read<PlayerBloc>().add(
                      PlayerInitEvent(
                        contentId:   widget.contentId,
                        contentType: 'movie',
                      ),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ── Ready ─────────────────────────────────────────
          if (state is PlayerReady) {
            return _PlayerView(state: state);
          }

          // PlayerInitial — black while loading
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ── Main player view — reads from PlayerReady state ───────────
class _PlayerView extends StatelessWidget {
  final PlayerReady state;
  const _PlayerView({required this.state});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<PlayerBloc>()
          .add(const PlayerToggleControlsEvent()),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          // ── Video / backdrop ────────────────────────────
          Positioned.fill(
            child: Image.network(
              // In production swap with VideoPlayer(controller)
              // For now shows content backdrop as placeholder
              'https://img.dummyjson.com/product-images/1/2.webp',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: Colors.black),
            ),
          ),

          // Paused overlay
          if (!state.isPlaying)
            Positioned.fill(
              child: Container(color: Colors.black45),
            ),

          // ── Controls ────────────────────────────────────
          AnimatedOpacity(
            opacity:  state.showControls ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: state.showControls
                ? _Controls(state: state)
                : const SizedBox.shrink(),
          ),

          // ── Skip Intro ──────────────────────────────────
          if (state.showSkipIntro)
            Positioned(
              right:  AppSizes.spaceMD,
              bottom: 100,
              child:  _SkipIntroButton(),
            ),

          // ── Next Episode ─────────────────────────────────
          if (state.showNextEpisode)
            Positioned(
              right:  AppSizes.spaceMD,
              bottom: 100,
              child:  _NextEpisodeBanner(),
            ),
        ],
      ),
    );
  }
}

// ── Controls overlay ──────────────────────────────────────────
class _Controls extends StatelessWidget {
  final PlayerReady state;
  const _Controls({required this.state});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlayerBloc>();

    return Stack(
      children: [
        // Top gradient
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin:  Alignment.topCenter,
                end:    Alignment.bottomCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
        ),

        // Bottom gradient
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: 140,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin:  Alignment.bottomCenter,
                end:    Alignment.topCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
        ),

        // ── Top bar ────────────────────────────────────────
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceMD,
              vertical:   AppSizes.spaceXS,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white),
                  onPressed: () => context.pop(),
                ),
                const SizedBox(width: AppSizes.spaceXS),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize:       MainAxisSize.min,
                    children: [
                      Text(
                        'Now Playing',
                        style: AppTextStyles.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Season 1  •  Episode 1',
                        style: AppTextStyles.labelSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cast, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings_outlined,
                      color: Colors.white),
                  onPressed: () => _showSettingsSheet(context, state),
                ),
              ],
            ),
          ),
        ),

        // ── Center controls ─────────────────────────────────
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skip back
              GestureDetector(
                onTap: () =>
                    bloc.add(const PlayerSkipBackwardEvent()),
                child: const Icon(Icons.replay_10,
                    color: Colors.white, size: 40),
              ),
              const SizedBox(width: AppSizes.space5XL),

              // Play / Pause
              GestureDetector(
                onTap: () =>
                    bloc.add(const PlayerTogglePlayPauseEvent()),
                child: Container(
                  width:  72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size:  40,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.space5XL),

              // Skip forward
              GestureDetector(
                onTap: () =>
                    bloc.add(const PlayerSkipForwardEvent()),
                child: const Icon(Icons.forward_10,
                    color: Colors.white, size: 40),
              ),
            ],
          ),
        ),

        // ── Bottom controls ──────────────────────────────────
        Positioned(
          left: 0, right: 0, bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.spaceMD, 0,
                AppSizes.spaceMD, AppSizes.spaceSM,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Progress from BLoC state
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight:      3,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 6),
                      overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 14),
                      activeTrackColor:   AppColors.netflixRed,
                      inactiveTrackColor: Colors.white30,
                      thumbColor:         Colors.white,
                      overlayColor:       Colors.white24,
                    ),
                    child: Slider(
                      value:     state.progress.clamp(0.0, 1.0),
                      onChanged: (v) => bloc.add(PlayerSeekEvent(
                        position: Duration(
                          milliseconds:
                              (v * state.duration.inMilliseconds).round(),
                        ),
                      )),
                    ),
                  ),

                  // Time + action icons
                  Row(
                    children: [
                      // ✅ Formatted time from BLoC state
                      Text(
                        '${state.positionLabel} / ${state.durationLabel}',
                        style: AppTextStyles.labelSmall,
                      ),
                      const Spacer(),
                      // Subtitles
                      IconButton(
                        icon: const Icon(Icons.subtitles_outlined,
                            color: Colors.white,
                            size: AppSizes.iconMD),
                        onPressed: () =>
                            _showSubtitlesSheet(context, state),
                        padding:     EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: AppSizes.spaceMD),
                      // ✅ Mute driven by BLoC state
                      IconButton(
                        icon: Icon(
                          state.isMuted
                              ? Icons.volume_off
                              : Icons.volume_up,
                          color: Colors.white,
                          size:  AppSizes.iconMD,
                        ),
                        onPressed: () =>
                            bloc.add(const PlayerToggleMuteEvent()),
                        padding:     EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: AppSizes.spaceMD),
                      IconButton(
                        icon: const Icon(Icons.fullscreen,
                            color: Colors.white,
                            size: AppSizes.iconMD),
                        onPressed: () {},
                        padding:     EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSettingsSheet(BuildContext context, PlayerReady state) {
    showModalBottomSheet(
      context:         context,
      backgroundColor: AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXL)),
      ),
      // ✅ Pass bloc so sheet can dispatch events
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerBloc>(),
        child: _PlayerSettingsSheet(state: state),
      ),
    );
  }

  void _showSubtitlesSheet(BuildContext context, PlayerReady state) {
    showModalBottomSheet(
      context:         context,
      backgroundColor: AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusXL)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<PlayerBloc>(),
        child: _SubtitlesSheet(state: state),
      ),
    );
  }
}

// ── Skip Intro button ─────────────────────────────────────────
class _SkipIntroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white70),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceXXS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        ),
      ),
      // ✅ Dispatches to BLoC
      onPressed: () => context
          .read<PlayerBloc>()
          .add(const PlayerSkipIntroEvent()),
      child: Text(AppStrings.playerSkipIntro,
          style: AppTextStyles.labelLarge),
    );
  }
}

// ── Next Episode banner ───────────────────────────────────────
class _NextEpisodeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:   200,
      padding: const EdgeInsets.all(AppSizes.spaceSM),
      decoration: BoxDecoration(
        color:        AppColors.bgModal,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        border:       Border.all(color: AppColors.dividerLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Next Episode', style: AppTextStyles.labelMedium),
          const SizedBox(height: AppSizes.spaceXXS),
          Text('S1:E2 • Next Chapter',
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: AppSizes.spaceXS),
          SizedBox(
            width:  double.infinity,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
                foregroundColor: AppColors.textInverse,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                ),
                padding: EdgeInsets.zero,
              ),
              // ✅ Dispatches to BLoC
              onPressed: () => context
                  .read<PlayerBloc>()
                  .add(const PlayerNextEpisodeEvent()),
              child: Text(AppStrings.playerEpisode,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textInverse,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Settings sheet ────────────────────────────────────────────
class _PlayerSettingsSheet extends StatelessWidget {
  final PlayerReady state;
  const _PlayerSettingsSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spaceMD, AppSizes.spaceXL,
        AppSizes.spaceMD, AppSizes.spaceXXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width:  AppSizes.sheetHandleW,
              height: AppSizes.sheetHandleH,
              decoration: BoxDecoration(
                color:        AppColors.dividerLight,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceXL),
          Text('Playback Settings', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.spaceXL),
          _SettingsTile(
            icon: Icons.speed, label: AppStrings.playerSpeed, value: '1×',
            onTap: () {},
          ),
          // ✅ Shows current quality from BLoC state
          _SettingsTile(
            icon: Icons.hd_outlined,
            label: AppStrings.playerQuality,
            value: state.selectedQuality,
            onTap: () => _showQualityPicker(context),
          ),
          _SettingsTile(
            icon: Icons.subtitles_outlined,
            label: AppStrings.playerSubtitles,
            value: state.selectedSubtitle ?? 'Off',
            onTap: () {},
          ),
          _SettingsTile(
            icon:  Icons.language,
            label: AppStrings.playerAudio,
            value: 'English',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void _showQualityPicker(BuildContext context) {
    final bloc = context.read<PlayerBloc>();
    showModalBottomSheet(
      context:         context,
      backgroundColor: AppColors.bgModal,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: _QualitySheet(current: state.selectedQuality),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final String       value;
  final VoidCallback onTap;
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: AppTextStyles.bodySmall),
          const Icon(Icons.chevron_right,
              color: AppColors.textTertiary, size: 20),
        ],
      ),
      onTap: onTap,
    );
  }
}

// ── Quality picker sheet ──────────────────────────────────────
class _QualitySheet extends StatelessWidget {
  final String current;
  const _QualitySheet({required this.current});

  static const _options = ['Auto', 'Low', 'Medium', 'High', '4K'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spaceMD, AppSizes.spaceXL,
        AppSizes.spaceMD, AppSizes.spaceXXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppStrings.playerQuality,
              style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.spaceMD),
          ..._options.map((opt) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(opt,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: opt == current
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                )),
            trailing: opt == current
                ? const Icon(Icons.check,
                    color: AppColors.netflixRed, size: 20)
                : null,
            onTap: () {
              // ✅ Dispatch quality change to BLoC
              context
                  .read<PlayerBloc>()
                  .add(PlayerSelectQualityEvent(quality: opt));
              Navigator.pop(context);
              Navigator.pop(context); // close settings too
            },
          )),
        ],
      ),
    );
  }
}

// ── Subtitles sheet ───────────────────────────────────────────
class _SubtitlesSheet extends StatelessWidget {
  final PlayerReady state;
  const _SubtitlesSheet({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.spaceMD, AppSizes.spaceXL,
        AppSizes.spaceMD, AppSizes.spaceXXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width:  AppSizes.sheetHandleW,
              height: AppSizes.sheetHandleH,
              decoration: BoxDecoration(
                color: AppColors.dividerLight,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceXL),
          Text(AppStrings.playerSubtitles,
              style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.spaceMD),
          // ✅ Options from BLoC state.subtitleOptions
          ...state.subtitleOptions.map((opt) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(opt,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: (state.selectedSubtitle ?? 'Off') == opt
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                )),
            trailing: (state.selectedSubtitle ?? 'Off') == opt
                ? const Icon(Icons.check,
                    color: AppColors.netflixRed, size: 20)
                : null,
            onTap: () {
              // ✅ Dispatch subtitle change to BLoC
              context.read<PlayerBloc>().add(PlayerSelectSubtitleEvent(
                language: opt == 'Off' ? null : opt,
              ));
              Future.delayed(const Duration(milliseconds: 200), () {
                if (context.mounted) Navigator.pop(context);
              });
            },
          )),
        ],
      ),
    );
  }
}