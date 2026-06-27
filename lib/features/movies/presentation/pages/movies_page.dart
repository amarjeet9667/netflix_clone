// lib/features/movies/presentation/pages/movies_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});
  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  String _selectedGenre = 'All';

  List<Map<String, dynamic>> get _filtered {
    if (_selectedGenre == 'All') return DummyMovies.movies;
    return DummyMovies.movies
        .where((m) => (m['genres'] as List).contains(_selectedGenre))
        .toList();
  }

  static const _genres = [
    'All', 'Action', 'Drama', 'Sci-Fi', 'Horror',
    'Thriller', 'Comedy', 'Crime', 'Romance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────
          SliverAppBar(
            pinned:          true,
            backgroundColor: AppColors.bgPrimary,
            title: Text(AppStrings.navMovies,
                style: AppTextStyles.headlineSmall),
            actions: [
              IconButton(
                icon: const Icon(Icons.search,
                    color: AppColors.textPrimary),
                onPressed: () => context.go(RouteNames.search),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: _GenreFilter(
                genres:   _genres,
                selected: _selectedGenre,
                onSelect: (g) => setState(() => _selectedGenre = g),
              ),
            ),
          ),

          // ── Featured Banner ──────────────────────────────
          SliverToBoxAdapter(
            child: _FeaturedBanner(
              movie: DummyMovies.trending.first,
            ),
          ),

          // ── Grid ─────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(AppSizes.spaceSM),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   3,
                crossAxisSpacing: AppSizes.spaceXS,
                mainAxisSpacing:  AppSizes.spaceXS,
                childAspectRatio: 0.67,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final movie = _filtered[i];
                  return _MovieGridCard(movie: movie);
                },
                childCount: _filtered.length,
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
}

// ── Genre filter chips ────────────────────────────────────────
class _GenreFilter extends StatelessWidget {
  final List<String>       genres;
  final String             selected;
  final ValueChanged<String> onSelect;
  const _GenreFilter({
    required this.genres,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceXS,
        ),
        itemCount:     genres.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppSizes.spaceXS),
        itemBuilder: (_, i) {
          final g      = genres[i];
          final active = g == selected;
          return GestureDetector(
            onTap: () => onSelect(g),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spaceMD,
                vertical:   AppSizes.spaceXXS,
              ),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.textPrimary
                    : AppColors.bgTertiary,
                borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
              ),
              child: Text(
                g,
                style: AppTextStyles.labelMedium.copyWith(
                  color: active
                      ? AppColors.textInverse
                      : AppColors.textSecondary,
                  fontWeight: active
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Featured banner at top of movies page ────────────────────
class _FeaturedBanner extends StatelessWidget {
  final Map<String, dynamic> movie;
  const _FeaturedBanner({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(
        RouteNames.movieDetailPath(movie['id'].toString()),
      ),
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(AppSizes.spaceSM),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
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
                  colors: [Colors.transparent, AppColors.black80],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            Positioned(
              left: AppSizes.spaceMD,
              bottom: AppSizes.spaceMD,
              right: AppSizes.spaceMD,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (movie['isNetflixOriginal'] == true)
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceXXS),
                      child: Text(
                        'N  ORIGINAL',
                        style: AppTextStyles.micro.copyWith(
                          color:         AppColors.textSecondary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  Text(
                    movie['title'] as String,
                    style: AppTextStyles.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceXXS),
                  Row(children: [
                    const Icon(Icons.play_arrow,
                        color: AppColors.textPrimary, size: 16),
                    const SizedBox(width: 4),
                    Text(AppStrings.btnPlay,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                        )),
                    const SizedBox(width: AppSizes.spaceMD),
                    const Icon(Icons.add,
                        color: AppColors.textSecondary, size: 16),
                    const SizedBox(width: 4),
                    Text(AppStrings.navMyList,
                        style: AppTextStyles.labelMedium),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Movie grid card ───────────────────────────────────────────
class _MovieGridCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  const _MovieGridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(
        RouteNames.movieDetailPath(movie['id'].toString()),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        child: Image.network(
          movie['posterUrl'] as String,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: AppColors.bgTertiary),
        ),
      ),
    );
  }
}