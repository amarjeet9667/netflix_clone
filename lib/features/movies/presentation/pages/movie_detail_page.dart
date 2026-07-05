// lib/features/movies/presentation/pages/movie_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:netflix_clone/shared/enums/content_type.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    // Ensure watchlist is loaded so we know if this item is in My List
    context.read<WatchlistBloc>().add(const WatchlistFetchEvent());
  }

  @override
  void dispose() { _tabs.dispose(); super.dispose(); }

  Map<String, dynamic>? get _movie {
    try {
      return DummyMovies.movies
          .firstWhere((m) => m['id'].toString() == widget.movieId);
    } catch (_) {
      return DummyMovies.movies.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = _movie;
    if (movie == null) {
      return const Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.netflixRed),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // ── Backdrop ──────────────────────────────────────
          SliverAppBar(
            expandedHeight:      300,
            pinned:              true,
            backgroundColor:     AppColors.bgPrimary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.download_outlined,
                    color: AppColors.textPrimary),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie['backdropUrl'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppColors.bgSecondary),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end:   Alignment.bottomCenter,
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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spaceMD,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(movie['title'] as String,
                      style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppSizes.spaceXS),

                  // Meta row
                  Row(
                    children: [
                      Text(
                        '${movie['releaseYear']}',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(width: AppSizes.spaceSM),
                      _MaturityBadge(rating: movie['maturityRating'] as String),
                      const SizedBox(width: AppSizes.spaceSM),
                      Text(
                        '${(movie['duration'] as int) ~/ 60}h ${(movie['duration'] as int) % 60}m',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(width: AppSizes.spaceSM),
                      if (movie['isNetflixOriginal'] == true)
                        Row(children: [
                          Text('N',
                            style: TextStyle(
                              color:      AppColors.netflixRed,
                              fontSize:   12,
                              fontWeight: FontWeight.w900,
                            )),
                          const SizedBox(width: 3),
                          Text('HD',
                            style: AppTextStyles.micro.copyWith(
                              color: AppColors.textTertiary,
                            )),
                        ]),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceSM),

                  // Match score
                  Text(
                    '${((movie['rating'] as double) * 10).round()}% Match',
                    style: AppTextStyles.matchScore,
                  ),
                  const SizedBox(height: AppSizes.spaceMD),

                  // Play button
                  SizedBox(
                    width:  double.infinity,
                    height: AppSizes.btnHeightLG,
                    child:  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnPlayBg,
                        foregroundColor: AppColors.btnPlayText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        ),
                      ),
                      icon:  const Icon(Icons.play_arrow, size: 24),
                      label: Text(AppStrings.btnPlay,
                          style: AppTextStyles.btnPrimary),
                      onPressed: () => context.go(
                        RouteNames.playerPath(widget.movieId),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceXS),

                  // Download button
                  SizedBox(
                    width:  double.infinity,
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
                      icon:  const Icon(Icons.download_outlined, size: 20),
                      label: Text(AppStrings.btnDownload,
                          style: AppTextStyles.btnSecondary),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceMD),

                  // Overview
                  Text(movie['overview'] as String,
                      style: AppTextStyles.overview),
                  const SizedBox(height: AppSizes.spaceSM),

                  // Cast
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: 'Cast: ',
                        style: AppTextStyles.bodySmall,
                      ),
                      TextSpan(
                        text: (movie['cast'] as List).join(', '),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: AppSizes.spaceXS),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: 'Director: ',
                        style: AppTextStyles.bodySmall,
                      ),
                      TextSpan(
                        text: movie['director'] as String,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: AppSizes.spaceXL),

                  // Action icons row
                  BlocBuilder<WatchlistBloc, WatchlistState>(
                    builder: (context, wState) {
                      final myList = wState is WatchlistLoaded
                          ? wState.myList
                          : wState is WatchlistItemToggled
                              ? wState.myList
                              : [];
                      final inList = myList.any((w) => w.contentId == widget.movieId);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ActionIcon(
                            icon:    inList ? Icons.check : Icons.add,
                            label:   inList ? AppStrings.btnRemoveList : AppStrings.btnAddToList,
                            onTap: () => context.read<WatchlistBloc>().add(
                              WatchlistToggleEvent(
                                contentId:   widget.movieId,
                                contentType: ContentType.movie,
                              ),
                            ),
                          ),
                          _ActionIcon(
                            icon:  Icons.thumb_up_outlined,
                            label: AppStrings.btnRate,
                            onTap: () {},
                          ),
                          _ActionIcon(
                            icon:  Icons.share_outlined,
                            label: AppStrings.btnShare,
                            onTap: () {},
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceXL),

                  // Tabs
                  TabBar(
                    controller: _tabs,
                    tabs: const [
                      Tab(text: 'Episodes'),
                      Tab(text: 'Trailers'),
                      Tab(text: 'More Like This'),
                    ],
                    labelStyle:           AppTextStyles.labelLarge,
                    unselectedLabelStyle: AppTextStyles.labelLarge,
                    labelColor:           AppColors.textPrimary,
                    unselectedLabelColor: AppColors.textTertiary,
                    indicatorColor:       AppColors.netflixRed,
                    dividerColor:         AppColors.divider,
                  ),
                  const SizedBox(height: AppSizes.spaceMD),
                ],
              ),
            ),
          ),

          // Tab content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabs,
              children: [
                _MoreLikeThis(currentId: widget.movieId),
                _TrailersTab(),
                _MoreLikeThis(currentId: widget.movieId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MaturityBadge extends StatelessWidget {
  final String rating;
  const _MaturityBadge({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.maturityBorder),
      ),
      child: Text(rating, style: AppTextStyles.maturityBadge),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final VoidCallback onTap;
  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
}

class _MoreLikeThis extends StatelessWidget {
  final String currentId;
  const _MoreLikeThis({required this.currentId});
  @override
  Widget build(BuildContext context) {
    final others = DummyMovies.movies
        .where((m) => m['id'].toString() != currentId)
        .take(6)
        .toList();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceMD,
        vertical:   AppSizes.spaceXS,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   3,
        crossAxisSpacing: AppSizes.spaceXS,
        mainAxisSpacing:  AppSizes.spaceXS,
        childAspectRatio: 0.67,
      ),
      itemCount:   others.length,
      itemBuilder: (context, i) {
        final m = others[i];
        return GestureDetector(
          onTap: () => context.go(
            RouteNames.movieDetailPath(m['id'].toString()),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            child: Image.network(
              m['posterUrl'] as String,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.bgTertiary),
            ),
          ),
        );
      },
    );
  }
}

class _TrailersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.spaceMD),
      itemCount: 3,
      itemBuilder: (_, i) => Container(
        margin:       const EdgeInsets.only(bottom: AppSizes.spaceMD),
        height:       160,
        decoration:   BoxDecoration(
          color:        AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color:        AppColors.bgTertiary,
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              ),
            ),
            const Icon(Icons.play_circle_outline,
                color: AppColors.textPrimary, size: 56),
          ],
        ),
      ),
    );
  }
}