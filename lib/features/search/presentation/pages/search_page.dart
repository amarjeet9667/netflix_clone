// lib/features/search/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../../domain/entities/genre_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../bloc/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _ctrl  = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Load genres for the initial Browse view
    context.read<SearchBloc>().add(const SearchFetchGenresEvent());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search bar ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.spaceMD, AppSizes.spaceMD,
                AppSizes.spaceMD, 0,
              ),
              child: BlocBuilder<SearchBloc, SearchState>(
                buildWhen: (prev, curr) =>
                    curr is SearchInitial || curr is SearchTyping ||
                    curr is SearchLoaded  || curr is SearchEmpty,
                builder: (context, state) {
                  final hasQuery = _ctrl.text.isNotEmpty;
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.bgTertiary,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusSM),
                          ),
                          child: TextField(
                            controller: _ctrl,
                            focusNode:  _focus,
                            // ✅ Dispatches to BLoC with debounce built in
                            onChanged: (query) => context
                                .read<SearchBloc>()
                                .add(SearchQueryChangedEvent(query: query)),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            cursorColor: AppColors.textPrimary,
                            decoration: InputDecoration(
                              hintText:  AppStrings.searchHint,
                              hintStyle: AppTextStyles.bodyMedium,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: AppColors.textTertiary,
                                size:  AppSizes.iconMD,
                              ),
                              suffixIcon: hasQuery
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppColors.textTertiary,
                                        size:  AppSizes.iconSM,
                                      ),
                                      onPressed: () {
                                        _ctrl.clear();
                                        context
                                            .read<SearchBloc>()
                                            .add(const SearchClearEvent());
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      if (hasQuery) ...[
                        const SizedBox(width: AppSizes.spaceSM),
                        TextButton(
                          onPressed: () {
                            _ctrl.clear();
                            _focus.unfocus();
                            context
                                .read<SearchBloc>()
                                .add(const SearchClearEvent());
                          },
                          child: Text('Cancel',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              )),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: AppSizes.spaceXL),

            // ── Body — fully driven by SearchBloc state ───────
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return _BrowseByGenre(genres: state.genres);
                  }
                  if (state is SearchGenresLoaded) {
                    return _BrowseByGenre(genres: state.genres);
                  }
                  if (state is SearchTyping) {
                    return Center(
                      child: Text(
                        'Keep typing…',
                        style: AppTextStyles.bodyMedium,
                      ),
                    );
                  }
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.netflixRed,
                      ),
                    );
                  }
                  if (state is SearchEmpty) {
                    return _EmptyResults(query: state.query);
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text(state.message,
                          style: AppTextStyles.bodyMedium),
                    );
                  }
                  if (state is SearchLoaded) {
                    return _SearchResults(results: state.results);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Browse By Genre ───────────────────────────────────────────
class _BrowseByGenre extends StatelessWidget {
  final List<GenreEntity> genres;
  const _BrowseByGenre({required this.genres});

  static const _colors = [
    Color(0xFF0F3460), Color(0xFF533483),
    Color(0xFF1B4332), Color(0xFF7B2D00),
    Color(0xFF1A1A2E), Color(0xFF2D1B00),
  ];

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.netflixRed),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMD),
          child: Text(AppStrings.browseByGenre,
              style: AppTextStyles.titleMedium),
        ),
        const SizedBox(height: AppSizes.spaceMD),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMD),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   2,
              crossAxisSpacing: AppSizes.spaceXS,
              mainAxisSpacing:  AppSizes.spaceXS,
              childAspectRatio: 2.8,
            ),
            itemCount:   genres.length,
            itemBuilder: (_, i) => _GenreTile(
              genre: genres[i],
              color: _colors[i % _colors.length],
            ),
          ),
        ),
      ],
    );
  }
}

class _GenreTile extends StatelessWidget {
  final GenreEntity genre;
  final Color       color;
  const _GenreTile({required this.genre, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Treat genre tap as a search query for that genre name
        context.read<SearchBloc>().add(
          SearchQueryChangedEvent(query: genre.name),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color:        color,
          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMD,
            vertical:   AppSizes.spaceSM,
          ),
          child: Row(
            children: [
              Text(genre.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: AppSizes.spaceXS),
              Expanded(
                child: Text(
                  genre.name,
                  style: AppTextStyles.labelLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Search Results ────────────────────────────────────────────
class _SearchResults extends StatelessWidget {
  final List<SearchResultEntity> results;
  const _SearchResults({required this.results});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.spaceMD),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:   3,
        crossAxisSpacing: AppSizes.spaceXS,
        mainAxisSpacing:  AppSizes.spaceXS,
        childAspectRatio: 0.67,
      ),
      itemCount:   results.length,
      itemBuilder: (context, i) {
        final item = results[i];
        return GestureDetector(
          onTap: () => context.go(RouteNames.movieDetailPath(item.id)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  item.posterUrl.isNotEmpty
                      ? item.posterUrl
                      : item.backdropUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.bgTertiary,
                    child: const Icon(Icons.movie,
                        color: AppColors.textTertiary),
                  ),
                ),
                if (item.isNetflixOriginal)
                  Positioned(
                    top: 4, left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.black60,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusXS),
                      ),
                      child: Text('N',
                          style: AppTextStyles.micro.copyWith(
                            color:      AppColors.netflixRed,
                            fontWeight: FontWeight.w900,
                          )),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Empty results ──────────────────────────────────────────────
class _EmptyResults extends StatelessWidget {
  final String query;
  const _EmptyResults({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spaceXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off,
                color: AppColors.textTertiary, size: 56),
            const SizedBox(height: AppSizes.spaceMD),
            Text(
              '${AppStrings.noResults} "$query"',
              style:     AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceXS),
            Text(
              AppStrings.emptySearch,
              style:     AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}