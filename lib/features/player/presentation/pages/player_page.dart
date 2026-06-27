// lib/features/player/presentation/pages/player_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class PlayerPage extends StatefulWidget {
  final String contentId;
  const PlayerPage({super.key, required this.contentId});
  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage>
    with SingleTickerProviderStateMixin {
  bool   _showControls   = true;
  bool   _isPlaying      = false;
  bool   _isMuted        = false;
  double _progress       = 0.22;
  double _volume         = 1.0;
  late AnimationController _fadeCtrl;
  late Animation<double>   _fadeAnim;

  Map<String, dynamic>? get _content {
    try {
      return DummyMovies.movies
          .firstWhere((m) => m['id'].toString() == widget.contentId);
    } catch (_) {
      return DummyMovies.movies.first;
    }
  }

  @override
  void initState() {
    super.initState();
    // Force landscape + hide status bar for player
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _fadeCtrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut);
    _fadeCtrl.value = 1.0;

    // Auto-hide controls after 3 seconds
    _scheduleHide();
  }

  @override
  void dispose() {
    // Restore portrait + system UI on exit
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _scheduleHide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) _hideControls();
    });
  }

  void _toggleControls() {
    if (_showControls) {
      _hideControls();
    } else {
      _showControlsNow();
    }
  }

  void _showControlsNow() {
    setState(() => _showControls = true);
    _fadeCtrl.forward();
    _scheduleHide();
  }

  void _hideControls() {
    _fadeCtrl.reverse().then((_) {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) _scheduleHide();
  }

  @override
  Widget build(BuildContext context) {
    final content = _content;
    final title   = content?['title'] as String? ?? 'Loading…';
    final total   = (content?['duration'] as int? ?? 148) * 60; // seconds
    final watched = (_progress * total).round();

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            // ── Video placeholder ───────────────────────────
            Positioned.fill(
              child: content != null
                  ? Image.network(
                      content['backdropUrl'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: Colors.black),
                    )
                  : Container(color: Colors.black),
            ),

            // Dark overlay when paused
            if (!_isPlaying)
              Positioned.fill(
                child: Container(color: Colors.black45),
              ),

            // ── Controls overlay ────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: _showControls
                  ? Stack(
                      children: [
                        // Top gradient
                        Positioned(
                          top: 0, left: 0, right: 0,
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end:   Alignment.bottomCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.transparent,
                                ],
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
                                begin: Alignment.bottomCenter,
                                end:   Alignment.topCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Top bar
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spaceMD,
                              vertical:   AppSizes.spaceXS,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => context.pop(),
                                ),
                                const SizedBox(width: AppSizes.spaceXS),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(title,
                                          style: AppTextStyles.titleSmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      Text(
                                        'Season 1  •  Episode 3',
                                        style: AppTextStyles.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                // Cast icon
                                IconButton(
                                  icon: const Icon(Icons.cast,
                                      color: Colors.white),
                                  onPressed: () {},
                                ),
                                // Settings
                                IconButton(
                                  icon: const Icon(Icons.settings_outlined,
                                      color: Colors.white),
                                  onPressed: () =>
                                      _showSettingsSheet(context),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Center play controls
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Seek back 10s
                              _SeekButton(
                                icon:    Icons.replay_10,
                                onPress: () => setState(() {
                                  _progress =
                                      (_progress - 0.05).clamp(0.0, 1.0);
                                }),
                              ),
                              const SizedBox(width: AppSizes.space5XL),
                              // Play / Pause
                              GestureDetector(
                                onTap: _togglePlay,
                                child: Container(
                                  width:  72,
                                  height: 72,
                                  decoration: const BoxDecoration(
                                    color:  Colors.white24,
                                    shape:  BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size:  40,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.space5XL),
                              // Seek forward 10s
                              _SeekButton(
                                icon:    Icons.forward_10,
                                onPress: () => setState(() {
                                  _progress =
                                      (_progress + 0.05).clamp(0.0, 1.0);
                                }),
                              ),
                            ],
                          ),
                        ),

                        // Bottom controls
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
                                  // Skip Intro button
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.white70),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.spaceMD,
                                          vertical:   AppSizes.spaceXXS,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.radiusSM),
                                        ),
                                      ),
                                      onPressed: () => setState(
                                          () => _progress = 0.15),
                                      child: Text(
                                        AppStrings.playerSkipIntro,
                                        style: AppTextStyles.labelLarge,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.spaceXS),

                                  // Progress scrubber
                                  SliderTheme(
                                    data: SliderThemeData(
                                      trackHeight:    3,
                                      thumbShape:
                                          const RoundSliderThumbShape(
                                              enabledThumbRadius: 6),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                              overlayRadius: 14),
                                      activeTrackColor:   AppColors.netflixRed,
                                      inactiveTrackColor: Colors.white30,
                                      thumbColor:         Colors.white,
                                      overlayColor:       Colors.white24,
                                    ),
                                    child: Slider(
                                      value:    _progress,
                                      onChanged: (v) =>
                                          setState(() => _progress = v),
                                    ),
                                  ),

                                  // Time + actions row
                                  Row(
                                    children: [
                                      Text(
                                        '${_formatTime(watched)} / ${_formatTime(total)}',
                                        style: AppTextStyles.labelSmall,
                                      ),
                                      const Spacer(),
                                      // Subtitles
                                      IconButton(
                                        icon: const Icon(
                                          Icons.subtitles_outlined,
                                          color: Colors.white,
                                          size:  AppSizes.iconMD,
                                        ),
                                        onPressed: () =>
                                            _showSubtitlesSheet(context),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const SizedBox(width: AppSizes.spaceMD),
                                      // Volume
                                      IconButton(
                                        icon: Icon(
                                          _isMuted
                                              ? Icons.volume_off
                                              : Icons.volume_up,
                                          color: Colors.white,
                                          size:  AppSizes.iconMD,
                                        ),
                                        onPressed: () => setState(
                                            () => _isMuted = !_isMuted),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                      ),
                                      const SizedBox(width: AppSizes.spaceMD),
                                      // Fullscreen
                                      IconButton(
                                        icon: const Icon(
                                          Icons.fullscreen,
                                          color: Colors.white,
                                          size:  AppSizes.iconMD,
                                        ),
                                        onPressed: () {},
                                        padding: EdgeInsets.zero,
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
                    )
                  : const SizedBox.shrink(),
            ),

            // ── Next episode banner (shows at 90%) ──────────
            if (_progress >= 0.9)
              Positioned(
                right:  AppSizes.spaceMD,
                bottom: 100,
                child: _NextEpisodeBanner(),
              ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:'
             '${m.toString().padLeft(2, '0')}:'
             '${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:'
           '${s.toString().padLeft(2, '0')}';
  }

  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context:          context,
      backgroundColor:  AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXL),
        ),
      ),
      builder: (_) => const _PlayerSettingsSheet(),
    );
  }

  void _showSubtitlesSheet(BuildContext context) {
    showModalBottomSheet(
      context:         context,
      backgroundColor: AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXL),
        ),
      ),
      builder: (_) => const _SubtitlesSheet(),
    );
  }
}

// ── Seek button ───────────────────────────────────────────────
class _SeekButton extends StatelessWidget {
  final IconData     icon;
  final VoidCallback onPress;
  const _SeekButton({required this.icon, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Icon(icon, color: Colors.white, size: 40),
    );
  }
}

// ── Next episode banner ───────────────────────────────────────
class _NextEpisodeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:   200,
      padding: const EdgeInsets.all(AppSizes.spaceSM),
      decoration: BoxDecoration(
        color:        AppColors.bgModal,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Next Episode', style: AppTextStyles.labelMedium),
          const SizedBox(height: AppSizes.spaceXXS),
          Text('S1:E4 • Chapter Four',
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: AppSizes.spaceXS),
          SizedBox(
            width:  double.infinity,
            height: 32,
            child:  ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
                foregroundColor: AppColors.textInverse,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
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

// ── Settings bottom sheet ─────────────────────────────────────
class _PlayerSettingsSheet extends StatelessWidget {
  const _PlayerSettingsSheet();
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
              width: AppSizes.sheetHandleW,
              height: AppSizes.sheetHandleH,
              decoration: BoxDecoration(
                color: AppColors.dividerLight,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceXL),
          Text('Playback Settings', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.spaceXL),
          _SettingsRow(
            icon:  Icons.speed,
            label: AppStrings.playerSpeed,
            value: '1×',
          ),
          _SettingsRow(
            icon:  Icons.hd_outlined,
            label: AppStrings.playerQuality,
            value: 'Auto',
          ),
          _SettingsRow(
            icon:  Icons.subtitles_outlined,
            label: AppStrings.playerSubtitles,
            value: 'Off',
          ),
          _SettingsRow(
            icon:  Icons.language,
            label: AppStrings.playerAudio,
            value: 'English',
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String   label;
  final String   value;
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textSecondary),
      title:   Text(label,
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
      onTap: () {},
    );
  }
}

// ── Subtitles bottom sheet ────────────────────────────────────
class _SubtitlesSheet extends StatefulWidget {
  const _SubtitlesSheet();
  @override
  State<_SubtitlesSheet> createState() => _SubtitlesSheetState();
}

class _SubtitlesSheetState extends State<_SubtitlesSheet> {
  String _selected = 'Off';
  static const _options = ['Off', 'English', 'Hindi', 'Spanish', 'French'];

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
              width: AppSizes.sheetHandleW,
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
          ..._options.map((opt) => ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(opt,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _selected == opt
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                )),
            trailing: _selected == opt
                ? const Icon(Icons.check,
                    color: AppColors.netflixRed, size: 20)
                : null,
            onTap: () {
              setState(() => _selected = opt);
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