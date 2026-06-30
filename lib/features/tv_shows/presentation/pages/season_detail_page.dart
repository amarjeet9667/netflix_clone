// lib/features/tv_shows/presentation/pages/season_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../../domain/entities/episode_entity.dart';
import '../bloc/tvshow_bloc.dart';

class SeasonDetailPage extends StatefulWidget {
  final String showId;
  final int seasonNumber;
  const SeasonDetailPage({
    super.key,
    required this.showId,
    required this.seasonNumber,
  });
  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TVShowBloc>().add(
      TVShowFetchEpisodesEvent(
        showId: widget.showId,
        seasonNumber: widget.seasonNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: AppSizes.iconMD,
          ),
          onPressed: () => context.pop(),
        ),
        title: BlocBuilder<TVShowBloc, TVShowState>(
          builder: (context, state) {
            final count = state is TVShowDetailLoaded
                ? state.episodes.length
                : 0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Season ${widget.seasonNumber}',
                  style: AppTextStyles.titleSmall,
                ),
                Text('$count Episodes', style: AppTextStyles.labelSmall),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<TVShowBloc, TVShowState>(
        builder: (context, state) {
          if (state is TVShowLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.netflixRed),
            );
          }
          if (state is TVShowError) {
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          }
          if (state is TVShowDetailLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(AppSizes.spaceMD),
              itemCount: state.episodes.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSizes.spaceMD),
                child: Divider(color: AppColors.divider),
              ),
              itemBuilder: (context, i) {
                final ep = state.episodes[i];
                return _SeasonEpisodeTile(
                  episode: ep,
                  onPlay: () =>
                      context.go(RouteNames.playerPath(widget.showId)),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SeasonEpisodeTile extends StatelessWidget {
  final EpisodeEntity episode;
  final VoidCallback onPlay;
  const _SeasonEpisodeTile({required this.episode, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onPlay,
          child: Container(
            width: 140,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors.bgTertiary,
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  episode.stillUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.bgTertiary),
                ),
                if (episode.isInProgress)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: LinearProgressIndicator(
                      value: episode.watchProgress,
                      backgroundColor: AppColors.progressBg,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.netflixRed,
                      ),
                      minHeight: 3,
                    ),
                  ),
                Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.black60,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.spaceXXS,
                  left: AppSizes.spaceXS,
                  child: Text(
                    '${episode.episodeNumber}',
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontSize: 32,
                      color: AppColors.white60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.spaceMD),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      episode.title,
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
              Text(episode.durationLabel, style: AppTextStyles.episodeMeta),
              const SizedBox(height: AppSizes.spaceXXS),
              Text(
                episode.overview,
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
