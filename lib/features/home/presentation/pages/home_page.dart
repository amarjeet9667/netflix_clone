// lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bannerIndex = 0;
  final PageController _bannerCtrl = PageController();

  @override
  void dispose() { _bannerCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final banners  = DummyBanners.featuredBanners;
    final sections = DummyHomeSections.sections;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      extendBodyBehindAppBar: true,
      appBar: _HomeAppBar(),
      body: CustomScrollView(
        slivers: [
          // ── Hero Banner ───────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppSizes.heroBannerH,
              child: Stack(
                children: [
                  // Banner pager
                  PageView.builder(
                    controller:  _bannerCtrl,
                    itemCount:   banners.length,
                    onPageChanged: (i) => setState(() => _bannerIndex = i),
                    itemBuilder: (_, i) => _HeroBannerSlide(
                      data: banners[i],
                    ),
                  ),

                  // Bottom gradient + controls
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.heroBannerGradient,
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        AppSizes.spaceMD, 80,
                        AppSizes.spaceMD, AppSizes.spaceMD,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Dot indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(banners.length, (i) {
                              final active = i == _bannerIndex;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 3),
                                width:  active ? 20 : 6,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: active
                                      ? AppColors.textPrimary
                                      : AppColors.textTertiary,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: AppSizes.spaceMD),
                          // Action buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // My List
                              _BannerAction(
                                icon:  Icons.add,
                                label: AppStrings.navMyList,
                                onTap: () {},
                              ),
                              const SizedBox(width: AppSizes.spaceXXL),
                              // Play button
                              SizedBox(
                                width:  120,
                                height: AppSizes.btnHeightLG,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.btnPlayBg,
                                    foregroundColor: AppColors.btnPlayText,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  icon: const Icon(Icons.play_arrow, size: 22),
                                  label: Text(AppStrings.btnPlay,
                                    style: AppTextStyles.btnPrimary),
                                  onPressed: () => context.go(
                                    RouteNames.playerPath(
                                      banners[_bannerIndex]['contentId'].toString(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceXXL),
                              // Info
                              _BannerAction(
                                icon:  Icons.info_outline,
                                label: 'Info',
                                onTap: () => context.go(
                                  RouteNames.movieDetailPath(
                                    banners[_bannerIndex]['contentId'].toString(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content Rows ──────────────────────────────────
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => _ContentRow(section: sections[i]),
              childCount: sections.length,
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

// ── Home App Bar ─────────────────────────────────────────────
class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarH);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.navTopGradient,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.screenPaddingH,
          ),
          child: Row(
            children: [
              // Netflix logo
              Text(
                'N',
                style: TextStyle(
                  fontSize:   36,
                  fontWeight: FontWeight.w900,
                  color:      AppColors.netflixRed,
                ),
              ),
              const Spacer(),
              // Category pills
              _NavPill(label: AppStrings.navTvShows,
                onTap: () => context.go(RouteNames.tvShows)),
              const SizedBox(width: AppSizes.spaceXS),
              _NavPill(label: AppStrings.navMovies,
                onTap: () => context.go(RouteNames.movies)),
              const SizedBox(width: AppSizes.spaceXS),
              _NavPill(label: AppStrings.navMyList,
                onTap: () => context.go(RouteNames.myList)),
              const SizedBox(width: AppSizes.spaceSM),
              // Search icon
              IconButton(
                icon: const Icon(Icons.search,
                    color: AppColors.textPrimary, size: AppSizes.iconLG),
                onPressed: () => context.go(RouteNames.search),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: AppSizes.spaceSM),
              // Profile avatar
              GestureDetector(
                onTap: () => context.go(RouteNames.account),
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.bgTertiary,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    DummyUsers.loggedInUser['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person, color: AppColors.textSecondary, size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavPill({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceSM,
          vertical:   AppSizes.spaceXXS,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white40, width: 1),
          borderRadius: BorderRadius.circular(AppSizes.radiusXXL),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
              )),
            const SizedBox(width: 2),
            const Icon(Icons.keyboard_arrow_down,
                color: AppColors.textPrimary, size: 14),
          ],
        ),
      ),
    );
  }
}

class _BannerAction extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final VoidCallback onTap;
  const _BannerAction({
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
          Icon(icon, color: AppColors.textPrimary, size: AppSizes.iconXL),
          const SizedBox(height: AppSizes.spaceXXS),
          Text(label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            )),
        ],
      ),
    );
  }
}

// ── Hero Banner Slide ─────────────────────────────────────────
class _HeroBannerSlide extends StatelessWidget {
  final Map<String, dynamic> data;
  const _HeroBannerSlide({required this.data});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          data['backdropUrl'] as String,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: AppColors.bgSecondary),
        ),
        // Top fade
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [AppColors.black60, Colors.transparent],
            ),
          ),
        ),
        // Title text
        Positioned(
          left: AppSizes.spaceMD,
          bottom: 160,
          right: AppSizes.spaceMD,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data['title'] as String,
                textAlign: TextAlign.center,
                style: AppTextStyles.heroBannerTitle,
              ),
              const SizedBox(height: AppSizes.spaceXS),
              // Genre tags
              Text(
                (data['genres'] as List).join(' • '),
                style: AppTextStyles.heroBannerGenre,
              ),
              // Netflix Original badge
              if (data['isNetflixOriginal'] == true) ...[
                const SizedBox(height: AppSizes.spaceXS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'N',
                      style: TextStyle(
                        color: AppColors.netflixRed,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'SERIES',
                      style: AppTextStyles.micro.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ── Content Row ───────────────────────────────────────────────
class _ContentRow extends StatelessWidget {
  final Map<String, dynamic> section;
  const _ContentRow({required this.section});

  @override
  Widget build(BuildContext context) {
    final items = section['items'] as List<Map<String, dynamic>>;
    final style = section['displayStyle'] as String;
    final isNumbered = style == 'numbered';

    final cardW = isNumbered
        ? AppSizes.cardTop10W
        : style.contains('portrait')
            ? AppSizes.cardPortraitW
            : AppSizes.cardLandscapeW;
    final cardH = isNumbered
        ? AppSizes.cardTop10H
        : style.contains('portrait')
            ? AppSizes.cardPortraitH
            : AppSizes.cardLandscapeH;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row title
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.rowTitlePaddingH, AppSizes.sectionSpacing,
            AppSizes.rowTitlePaddingH, AppSizes.rowTitlePaddingB,
          ),
          child: Row(
            children: [
              Text(section['title'] as String,
                style: AppTextStyles.rowTitle),
              const Spacer(),
              Text(AppStrings.btnSeeAll,
                style: AppTextStyles.seeAll),
              const Icon(Icons.chevron_right,
                  color: AppColors.textTertiary, size: 16),
            ],
          ),
        ),
        // Horizontal list
        SizedBox(
          height: cardH,
          child: ListView.builder(
            scrollDirection:  Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.screenPaddingH,
            ),
            itemCount:  items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return GestureDetector(
                onTap: () => context.go(
                  RouteNames.movieDetailPath(item['id'].toString()),
                ),
                child: Container(
                  width:  cardW,
                  margin: const EdgeInsets.only(right: AppSizes.cardSpacing),
                  child: isNumbered
                      ? _Top10Card(item: item, rank: i + 1)
                      : _StandardCard(item: item, cardH: cardH),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StandardCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final double cardH;
  const _StandardCard({required this.item, required this.cardH});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
      child: Image.network(
        item['posterUrl'] ?? item['backdropUrl'] ?? '',
        fit: BoxFit.cover,
        height: cardH,
        errorBuilder: (_, __, ___) => Container(
          color: AppColors.bgTertiary,
          child: const Icon(Icons.movie, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}

class _Top10Card extends StatelessWidget {
  final Map<String, dynamic> item;
  final int rank;
  const _Top10Card({required this.item, required this.rank});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Card image — shifted right to leave room for number
        Positioned(
          left: 36, right: 0, top: 0, bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            child: Image.network(
              item['posterUrl'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.bgTertiary,
              ),
            ),
          ),
        ),
        // Large rank number
        Positioned(
          left: 0, bottom: -8,
          child: Text(
            '$rank',
            style: AppTextStyles.top10Number.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = AppColors.bgPrimary,
            ),
          ),
        ),
        Positioned(
          left: 0, bottom: -8,
          child: Text('$rank', style: AppTextStyles.top10Number),
        ),
      ],
    );
  }
}