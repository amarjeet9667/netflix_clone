// lib/features/auth/presentation/pages/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/router/route_names.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _ctrl = PageController();
  int _current = 0;

  static const _pages = [
    _OnboardData(
      title:    'Watch everywhere.',
      subtitle: 'Stream unlimited movies and TV shows on your phone, tablet, laptop, and TV.',
      image:    'https://img.dummyjson.com/product-images/1/2.webp',
    ),
    _OnboardData(
      title:    'Download and go.',
      subtitle: 'Save your favourites easily and always have something to watch.',
      image:    'https://img.dummyjson.com/product-images/2/2.webp',
    ),
    _OnboardData(
      title:    'Create profiles for kids.',
      subtitle: 'Send kids on adventures with their favourite characters in a space made just for them.',
      image:    'https://img.dummyjson.com/product-images/3/2.webp',
    ),
  ];

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          // ── Pages ────────────────────────────────────────
          PageView.builder(
            controller:  _ctrl,
            itemCount:   _pages.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => _OnboardSlide(data: _pages[i]),
          ),

          // ── Top bar ──────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingH,
                vertical:   AppSizes.spaceMD,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NETFLIX',
                    style: AppTextStyles.titleLarge.copyWith(
                      color:         AppColors.netflixRed,
                      fontWeight:    FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.login),
                    child: Text(
                      AppStrings.signIn,
                      style: AppTextStyles.btnSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Bottom controls ───────────────────────────────
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.heroBannerGradient,
              ),
              padding: EdgeInsets.fromLTRB(
                AppSizes.screenPaddingH,
                AppSizes.space6XL,
                AppSizes.screenPaddingH,
                AppSizes.space3XL + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _current;
                      return AnimatedContainer(
                        duration: AppDurations.fast,
                        margin: const EdgeInsets.symmetric(
                          horizontal: AppSizes.dotSpacing,
                        ),
                        width:  active ? AppSizes.dotActive  : AppSizes.dotInactive,
                        height: active ? AppSizes.dotActive  : AppSizes.dotInactive,
                        decoration: BoxDecoration(
                          color:  active
                              ? AppColors.textPrimary
                              : AppColors.textTertiary,
                          shape:  BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSizes.spaceXL),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.btnHeightXL,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.netflixRed,
                        foregroundColor: AppColors.textPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                        ),
                      ),
                      onPressed: () {
                        if (_current < _pages.length - 1) {
                          _ctrl.nextPage(
                            duration: AppDurations.pageTransition,
                            curve:    Curves.easeInOut,
                          );
                        } else {
                          context.go(RouteNames.register);
                        }
                      },
                      child: Text(
                        _current < _pages.length - 1
                            ? 'Next'
                            : AppStrings.getStarted,
                        style: AppTextStyles.btnPrimary.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardSlide extends StatelessWidget {
  final _OnboardData data;
  const _OnboardSlide({required this.data});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(data.image, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: AppColors.bgSecondary)),
        // Dark gradient overlay
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end:   Alignment.bottomCenter,
              colors: [AppColors.black40, AppColors.bgPrimary],
              stops: [0.3, 0.85],
            ),
          ),
        ),
        // Text
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSizes.spaceMD, 0, AppSizes.spaceMD, 220,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineLarge.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceMD),
                Text(
                  data.subtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardData {
  final String title, subtitle, image;
  const _OnboardData({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

// ignore: undefined_identifier — replace with AppDurations import
const _fast = Duration(milliseconds: 150);
// ignore top level — just for reference, use AppDurations.fast
class AppDurations { static const fast = _fast; static const pageTransition = Duration(milliseconds: 300); }