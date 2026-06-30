// lib/features/tv_shows/presentation/pages/tvshows_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../../domain/entities/series_entity.dart';
import '../../domain/entities/episode_entity.dart';
import '../bloc/tvshow_bloc.dart';

class TVShowsPage extends StatefulWidget {
  final String? showId;
  const TVShowsPage({super.key, this.showId});
  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage> {
  bool get isDetail => widget.showId != null;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<TVShowBloc>();
    if (isDetail) {
      bloc.add(TVShowFetchDetailEvent(showId: widget.showId!));
    } else {
      bloc.add(const TVShowFetchAllEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isDetail ? const _ShowDetailView() : const _BrowseView();
  }
}

// ── Browse all shows ──────────────────────────────────────────
class _BrowseView extends StatelessWidget {
  const _BrowseView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: BlocBuilder<TVShowBloc, TVShowState>(
        builder: (context, state) {
          if (state is TVShowLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.netflixRed),
            );
          }
          if (state is TVShowError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    color: AppColors.textTertiary,
                    size: 48,
                  ),
                  const SizedBox(height: AppSizes.spaceMD),
                  Text(state.message, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: AppSizes.spaceMD),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.netflixRed,
                    ),
                    onPressed: () => context.read<TVShowBloc>().add(
                      const TVShowFetchAllEvent(),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is TVShowListLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColors.bgPrimary,
                  title: Text(
                    AppStrings.navTvShows,
                    style: AppTextStyles.headlineSmall,
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => context.go(RouteNames.search),
                    ),
                  ],
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSizes.spaceSM),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSizes.spaceXS,
                          mainAxisSpacing: AppSizes.spaceXS,
                          childAspectRatio: 1.6,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _ShowCard(show: state.shows[i]),
                      childCount: state.shows.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.space5XL),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ShowCard extends StatelessWidget {
  final SeriesEntity show;
  const _ShowCard({required this.show});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(RouteNames.showDetailPath(show.id.toString())),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              show.backdropUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.bgTertiary),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.black80],
                  stops: [0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              left: AppSizes.spaceXS,
              bottom: AppSizes.spaceXS,
              right: AppSizes.spaceXS,
              child: Text(
                show.title,
                style: AppTextStyles.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Show detail view ──────────────────────────────────────────
class _ShowDetailView extends StatelessWidget {
  const _ShowDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
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
            return _DetailContent(state: state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  final TVShowDetailLoaded state;
  const _DetailContent({required this.state});

  @override
  Widget build(BuildContext context) {
    final show = state.show;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: AppColors.bgPrimary,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.textPrimary,
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  show.backdropUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.bgSecondary),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, AppColors.bgPrimary],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(show.title, style: AppTextStyles.headlineSmall),
                const SizedBox(height: AppSizes.spaceXS),
                Row(
                  children: [
                    Text('${show.releaseYear}', style: AppTextStyles.bodySmall),
                    const SizedBox(width: AppSizes.spaceSM),
                    _Badge(show.maturityRating),
                    const SizedBox(width: AppSizes.spaceSM),
                    Text(
                      '${show.totalSeasons} Seasons',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceXS),
                Text(
                  '${show.matchScore}% Match',
                  style: AppTextStyles.matchScore,
                ),
                const SizedBox(height: AppSizes.spaceMD),

                SizedBox(
                  width: double.infinity,
                  height: AppSizes.btnHeightLG,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.btnPlayBg,
                      foregroundColor: AppColors.btnPlayText,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      ),
                    ),
                    icon: const Icon(Icons.play_arrow, size: 24),
                    label: Text('Play S1:E1', style: AppTextStyles.btnPrimary),
                    onPressed: () =>
                        context.go(RouteNames.playerPath(show.id.toString())),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceXS),

                SizedBox(
                  width: double.infinity,
                  height: AppSizes.btnHeightLG,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      backgroundColor: AppColors.btnSecondaryBg,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      ),
                    ),
                    icon: const Icon(Icons.download_outlined, size: 20),
                    label: Text(
                      AppStrings.btnDownload,
                      style: AppTextStyles.btnSecondary,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: AppSizes.spaceMD),

                Text(show.overview, style: AppTextStyles.overview),
                const SizedBox(height: AppSizes.spaceXL),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _IconAction(
                      icon: Icons.add,
                      label: AppStrings.navMyList,
                      onTap: () {},
                    ),
                    _IconAction(
                      icon: Icons.thumb_up_outlined,
                      label: AppStrings.btnRate,
                      onTap: () {},
                    ),
                    _IconAction(
                      icon: Icons.share_outlined,
                      label: AppStrings.btnShare,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceXL),

                // ── Season selector ─────────────────────────
                GestureDetector(
                  onTap: () => _showSeasonPicker(context, show.totalSeasons),
                  child: Row(
                    children: [
                      Text(
                        'Season ${state.selectedSeason}',
                        style: AppTextStyles.titleSmall,
                      ),
                      const SizedBox(width: AppSizes.spaceXS),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.spaceMD),

                // ── Episodes — directly from BLoC state ─────
                ...state.episodes.map(
                  (ep) => _EpisodeTile(
                    episode: ep,
                    onPlay: () =>
                        context.go(RouteNames.playerPath(show.id.toString())),
                  ),
                ),

                const SizedBox(height: AppSizes.space5XL),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSeasonPicker(BuildContext context, int totalSeasons) {
    final bloc = context.read<TVShowBloc>();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXL),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(totalSeasons, (i) {
            final n = i + 1;
            return ListTile(
              title: Text(
                'Season $n',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              trailing: n == state.selectedSeason
                  ? const Icon(Icons.check, color: AppColors.netflixRed)
                  : null,
              onTap: () {
                // ✅ Dispatch to BLoC
                bloc.add(TVShowSelectSeasonEvent(seasonNumber: n));
                Navigator.pop(context);
              },
            );
          }),
        ),
      ),
    );
  }
}

// ── Episode tile ──────────────────────────────────────────────
class _EpisodeTile extends StatelessWidget {
  final EpisodeEntity episode;
  final VoidCallback onPlay;
  const _EpisodeTile({required this.episode, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onPlay,
                child: Container(
                  width: 120,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    color: AppColors.bgTertiary,
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
                      Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.black60,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
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
                            '${episode.episodeNumber}. ${episode.title}',
                            style: AppTextStyles.labelLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                      episode.durationLabel,
                      style: AppTextStyles.episodeMeta,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceXS),
          Text(
            episode.overview,
            style: AppTextStyles.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (episode.isInProgress) ...[
            const SizedBox(height: AppSizes.spaceXS),
            LinearProgressIndicator(
              value: episode.watchProgress,
              backgroundColor: AppColors.progressBg,
              valueColor: const AlwaysStoppedAnimation(AppColors.netflixRed),
              minHeight: AppSizes.progressBarH,
            ),
          ],
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String rating;
  const _Badge(this.rating);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.maturityBorder),
    ),
    child: Text(rating, style: AppTextStyles.maturityBadge),
  );
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _IconAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.textPrimary, size: AppSizes.iconXXL),
        const SizedBox(height: AppSizes.spaceXXS),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    ),
  );
}
