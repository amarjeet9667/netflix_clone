// lib/features/tv_shows/presentation/pages/season_detail_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class SeasonDetailPage extends StatelessWidget {
  final String showId;
  final int    seasonNumber;
  const SeasonDetailPage({
    super.key,
    required this.showId,
    required this.seasonNumber,
  });

  @override
  Widget build(BuildContext context) {
    final season = DummyTVShows.seasons.firstWhere(
      (s) => s['showId'].toString() == showId &&
             s['seasonNumber'] == seasonNumber,
      orElse: () => DummyTVShows.seasons.first,
    );

    final episodes = DummyTVShows.episodes
        .where((e) => e['seasonId'] == season['id'])
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary,
              size: AppSizes.iconMD),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(season['title'] as String,
                style: AppTextStyles.titleSmall),
            Text(
              '${season['episodeCount']} Episodes · ${season['releaseYear']}',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Season overview
          Padding(
            padding: const EdgeInsets.all(AppSizes.spaceMD),
            child: Text(
              season['overview'] as String,
              style: AppTextStyles.bodyMedium,
            ),
          ),
          const Divider(color: AppColors.divider),

          // Episodes
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSizes.spaceMD),
              itemCount: episodes.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.spaceMD,
                ),
                child: Divider(color: AppColors.divider),
              ),
              itemBuilder: (context, i) {
                final ep = episodes[i];
                return _SeasonEpisodeTile(
                  episode: ep,
                  onPlay: () => context.go(
                    RouteNames.playerPath(showId),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SeasonEpisodeTile extends StatelessWidget {
  final Map<String, dynamic> episode;
  final VoidCallback         onPlay;
  const _SeasonEpisodeTile({
    required this.episode,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final progress = episode['watchProgress'] as double;
    final watched  = episode['hasBeenWatched'] as bool;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Thumbnail with play icon
        GestureDetector(
          onTap: onPlay,
          child: Container(
            width:  140,
            height: 84,
            decoration: BoxDecoration(
              color:        AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  episode['stillUrl'] as String,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.bgTertiary),
                ),
                // Progress bar at bottom of thumbnail
                if (watched && progress > 0 && progress < 1.0)
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: LinearProgressIndicator(
                      value:           progress,
                      backgroundColor: AppColors.progressBg,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.netflixRed,
                      ),
                      minHeight: 3,
                    ),
                  ),
                // Play overlay
                Center(
                  child: Container(
                    width:  36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.black60,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow,
                        color: Colors.white, size: 22),
                  ),
                ),
                // Episode number
                Positioned(
                  top:  AppSizes.spaceXXS,
                  left: AppSizes.spaceXS,
                  child: Text(
                    '${episode['episodeNumber']}',
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontSize:   32,
                      color:      AppColors.white60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceMD),

        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      episode['title'] as String,
                      style: AppTextStyles.labelLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceXS),
                  IconButton(
                    icon: const Icon(
                      Icons.download_outlined,
                      color: AppColors.textSecondary,
                      size: AppSizes.iconMD,
                    ),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              Text(
                '${episode['duration']}m',
                style: AppTextStyles.episodeMeta,
              ),
              const SizedBox(height: AppSizes.spaceXXS),
              Text(
                episode['overview'] as String,
                style: AppTextStyles.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}