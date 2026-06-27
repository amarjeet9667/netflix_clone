// lib/features/search/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _ctrl   = TextEditingController();
  final _focus  = FocusNode();
  String _query = '';
  List<Map<String, dynamic>> _results = [];

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _query   = query;
      _results = DummySearch.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final genres = DummyGenres.genres;

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
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color:        AppColors.bgTertiary,
                        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      ),
                      child: TextField(
                        controller:   _ctrl,
                        focusNode:    _focus,
                        onChanged:    _onSearch,
                        style:        AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        cursorColor:  AppColors.textPrimary,
                        decoration: InputDecoration(
                          hintText:    AppStrings.searchHint,
                          hintStyle:   AppTextStyles.bodyMedium,
                          prefixIcon:  const Icon(
                            Icons.search,
                            color: AppColors.textTertiary,
                            size:  AppSizes.iconMD,
                          ),
                          suffixIcon: _query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: AppColors.textTertiary,
                                    size:  AppSizes.iconSM,
                                  ),
                                  onPressed: () {
                                    _ctrl.clear();
                                    _onSearch('');
                                  },
                                )
                              : null,
                          border:      InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_query.isNotEmpty) ...[
                    const SizedBox(width: AppSizes.spaceSM),
                    TextButton(
                      onPressed: () {
                        _ctrl.clear();
                        _onSearch('');
                        _focus.unfocus();
                      },
                      child: Text('Cancel',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                        )),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spaceXL),

            // ── Results or Browse ────────────────────────────
            Expanded(
              child: _query.isEmpty
                  ? _BrowseByGenre(genres: genres)
                  : _SearchResults(results: _results, query: _query),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Browse By Genre ───────────────────────────────────────────
class _BrowseByGenre extends StatelessWidget {
  final List<Map<String, dynamic>> genres;
  const _BrowseByGenre({required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMD,
          ),
          child: Text(
            AppStrings.browseByGenre,
            style: AppTextStyles.titleMedium,
          ),
        ),
        const SizedBox(height: AppSizes.spaceMD),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spaceMD,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   2,
              crossAxisSpacing: AppSizes.spaceXS,
              mainAxisSpacing:  AppSizes.spaceXS,
              childAspectRatio: 2.8,
            ),
            itemCount:   genres.length,
            itemBuilder: (_, i) => _GenreTile(genre: genres[i]),
          ),
        ),
      ],
    );
  }
}

class _GenreTile extends StatelessWidget {
  final Map<String, dynamic> genre;
  const _GenreTile({required this.genre});

  static const _colors = [
    Color(0xFF0F3460), Color(0xFF533483),
    Color(0xFF1B4332), Color(0xFF7B2D00),
    Color(0xFF1A1A2E), Color(0xFF2D1B00),
  ];

  @override
  Widget build(BuildContext context) {
    final idx   = DummyGenres.genres.indexOf(genre) % _colors.length;
    return Container(
      decoration: BoxDecoration(
        color:        _colors[idx],
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceSM,
        ),
        child: Row(
          children: [
            Text(genre['icon'] as String, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: AppSizes.spaceXS),
            Expanded(
              child: Text(
                genre['name'] as String,
                style: AppTextStyles.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Search Results ────────────────────────────────────────────
class _SearchResults extends StatelessWidget {
  final List<Map<String, dynamic>> results;
  final String query;
  const _SearchResults({required this.results, required this.query});

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off,
                color: AppColors.textTertiary, size: 56),
            const SizedBox(height: AppSizes.spaceMD),
            Text(
              '${AppStrings.noResults} "$query"',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

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
          onTap: () => context.go(
            RouteNames.movieDetailPath(item['id'].toString()),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            child: Image.network(
              item['posterUrl'] ?? item['backdropUrl'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.bgTertiary,
                child: const Icon(
                  Icons.movie,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}