// lib/features/tv_shows/presentation/pages/tvshows_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class TVShowsPage extends StatefulWidget {
  final String? showId;
  const TVShowsPage({super.key, this.showId});
  @override
  State<TVShowsPage> createState() => _TVShowsPageState();
}

class _TVShowsPageState extends State<TVShowsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  int _selectedSeason = 1;

  bool get isDetail => widget.showId != null;

  Map<String, dynamic>? get _show {
    if (!isDetail) return null;
    try {
      return DummyTVShows.shows
          .firstWhere((s) => s['id'].toString() == widget.showId);
    } catch (_) {
      return DummyTVShows.shows.first;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isDetail ? _buildDetail(context) : _buildBrowse(context);
  }

  // ── Browse TV Shows ───────────────────────────────────────
  Widget _buildBrowse(BuildContext context) {
    final shows = DummyTVShows.shows;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned:          true,
            backgroundColor: AppColors.bgPrimary,
            title: Text(AppStrings.navTvShows,
                style: AppTextStyles.headlineSmall),
            actions: [
              IconButton(
                icon: const Icon(Icons.search,
                    color: AppColors.textPrimary),
                onPressed: () => context.go(RouteNames.search),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.spaceSM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   2,
                crossAxisSpacing: AppSizes.spaceXS,
                mainAxisSpacing:  AppSizes.spaceXS,
                childAspectRatio: 1.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ShowCard(show: shows[i]),
                childCount: shows.length,
              ),
            ),
          ),
          // Also show movies as shows for demo content
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spaceSM, 0,
              AppSizes.spaceSM, AppSizes.spaceSM,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   3,
                crossAxisSpacing: AppSizes.spaceXS,
                mainAxisSpacing:  AppSizes.spaceXS,
                childAspectRatio: 0.67,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final m = DummyMovies.movies[i];
                  return GestureDetector(
                    onTap: () => context.go(
                      RouteNames.showDetailPath(m['id'].toString()),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusSM),
                      child: Image.network(
                        m['posterUrl'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: AppColors.bgTertiary),
                      ),
                    ),
                  );
                },
                childCount: DummyMovies.movies.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.space5XL),
          ),
        ],
      ),
    );
  }

  // ── Show Detail ───────────────────────────────────────────
  Widget _buildDetail(BuildContext context) {
    final show = _show;
    if (show == null) {
      return const Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: Center(
          child: CircularProgressIndicator(
              color: AppColors.netflixRed),
        ),
      );
    }

    final seasons = DummyTVShows.seasons
        .where((s) => s['showId'] == show['id'])
        .toList();
    final episodes = DummyTVShows.episodes
        .where((e) => e['showId'] == show['id'])
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // Backdrop
          SliverAppBar(
            expandedHeight:  280,
            pinned:          true,
            backgroundColor: AppColors.bgPrimary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    show['backdropUrl'] as String? ??
                        'https://img.dummyjson.com/product-images/9/2.webp',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppColors.bgSecondary),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:   Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.bgPrimary,
                        ],
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
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.spaceMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(show['title'] as String,
                      style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppSizes.spaceXS),
                  Row(children: [
                    Text('${show['releaseYear']}',
                        style: AppTextStyles.bodySmall),
                    const SizedBox(width: AppSizes.spaceSM),
                    _Badge(show['maturityRating'] as String),
                    const SizedBox(width: AppSizes.spaceSM),
                    Text(
                      '${show['totalSeasons']} Seasons',
                      style: AppTextStyles.bodySmall,
                    ),
                  ]),
                  const SizedBox(height: AppSizes.spaceXS),
                  Text(
                    '${((show['rating'] as double )* 10).round()}% Match',
                    style: AppTextStyles.matchScore,
                  ),
                  const SizedBox(height: AppSizes.spaceMD),

                  // Play button
                  SizedBox(
                    width:  double.infinity,
                    height: AppSizes.btnHeightLG,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnPlayBg,
                        foregroundColor: AppColors.btnPlayText,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusSM),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow, size: 24),
                      label: Text(
                        'Play S1:E1',
                        style: AppTextStyles.btnPrimary,
                      ),
                      onPressed: () => context.go(
                        RouteNames.playerPath(show['id'].toString()),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceXS),

                  // Download
                  SizedBox(
                    width:  double.infinity,
                    height: AppSizes.btnHeightLG,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        backgroundColor: AppColors.btnSecondaryBg,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusSM),
                        ),
                      ),
                      icon: const Icon(
                          Icons.download_outlined, size: 20),
                      label: Text(AppStrings.btnDownload,
                          style: AppTextStyles.btnSecondary),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceMD),

                  Text(show['overview'] as String,
                      style: AppTextStyles.overview),
                  const SizedBox(height: AppSizes.spaceXL),

                  // Action row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _IconAction(
                        icon:  Icons.add,
                        label: AppStrings.navMyList,
                        onTap: () {},
                      ),
                      _IconAction(
                        icon:  Icons.thumb_up_outlined,
                        label: AppStrings.btnRate,
                        onTap: () {},
                      ),
                      _IconAction(
                        icon:  Icons.share_outlined,
                        label: AppStrings.btnShare,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceXL),

                  // Season selector
                  if (seasons.isNotEmpty) ...[
                    Row(children: [
                      Text(
                        'Season $_selectedSeason',
                        style: AppTextStyles.titleSmall,
                      ),
                      const SizedBox(width: AppSizes.spaceXS),
                      const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.textPrimary, size: 20),
                    ]),
                    const SizedBox(height: AppSizes.spaceMD),
                  ],

                  // Episodes list
                  ...episodes.map((e) => _EpisodeTile(
                    episode: e,
                    onPlay: () => context.go(
                      RouteNames.playerPath(show['id'].toString()),
                    ),
                  )),

                  const SizedBox(height: AppSizes.space5XL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Browse show card ──────────────────────────────────────────
class _ShowCard extends StatelessWidget {
  final Map<String, dynamic> show;
  const _ShowCard({required this.show});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(
        RouteNames.showDetailPath(show['id'].toString()),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              show['backdropUrl'] as String? ??
                  'https://img.dummyjson.com/product-images/9/2.webp',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.bgTertiary),
            ),
            Positioned(
              left:   AppSizes.spaceXS,
              bottom: AppSizes.spaceXS,
              right:  AppSizes.spaceXS,
              child: Text(
                show['title'] as String,
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

// ── Episode tile ──────────────────────────────────────────────
class _EpisodeTile extends StatelessWidget {
  final Map<String, dynamic> episode;
  final VoidCallback         onPlay;
  const _EpisodeTile({required this.episode, required this.onPlay});

  @override
  Widget build(BuildContext context) {
    final progress = episode['watchProgress'] as double;
    final watched  = episode['hasBeenWatched'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Thumbnail
              GestureDetector(
                onTap: onPlay,
                child: Container(
                  width:        120,
                  height:       72,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusSM),
                    color: AppColors.bgTertiary,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        episode['stillUrl'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.bgTertiary,
                        ),
                      ),
                      Center(
                        child: Container(
                          width:  32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.black60,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.play_arrow,
                              color: Colors.white, size: 20),
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
                    Row(children: [
                      Expanded(
                        child: Text(
                          '${episode['episodeNumber']}. ${episode['title']}',
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
                    ]),
                    Text(
                      '${episode['duration']}m',
                      style: AppTextStyles.episodeMeta,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceXS),
          Text(
            episode['overview'] as String,
            style: AppTextStyles.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (watched && progress > 0 && progress < 1.0) ...[
            const SizedBox(height: AppSizes.spaceXS),
            LinearProgressIndicator(
              value:           progress,
              backgroundColor: AppColors.progressBg,
              valueColor: const AlwaysStoppedAnimation(
                AppColors.netflixRed,
              ),
              minHeight: AppSizes.progressBarH,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Shared small widgets ──────────────────────────────────────
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
  final IconData     icon;
  final String       label;
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
        Icon(icon, color: AppColors.textPrimary,
            size: AppSizes.iconXXL),
        const SizedBox(height: AppSizes.spaceXXS),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    ),
  );
}