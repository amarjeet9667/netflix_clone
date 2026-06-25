// lib/features/user/presentation/pages/who_is_watching_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class WhoIsWatchingPage extends StatelessWidget {
  const WhoIsWatchingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = DummyUsers.profiles;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingH,
                vertical:   AppSizes.spaceXL,
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
                    onPressed: () => context.go(
                      '${RouteNames.whoIsWatching}/manage',
                    ),
                    child: Text(
                      AppStrings.manageProfiles,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Title
            Text(
              AppStrings.whoIsWatching,
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: AppSizes.space3XL),

            // Profile grid
            Wrap(
              spacing:     AppSizes.spaceXL,
              runSpacing:  AppSizes.spaceXL,
              alignment:   WrapAlignment.center,
              children: [
                ...profiles.map((p) => _ProfileTile(
                  profile:  p,
                  onTap: () => context.go(RouteNames.home),
                )),
                // Add profile
                _AddProfileTile(
                  onTap: () => context.go(
                    '${RouteNames.whoIsWatching}/edit',
                  ),
                ),
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final VoidCallback onTap;
  const _ProfileTile({required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.avatarXL,
        child: Column(
          children: [
            // Avatar
            Container(
              width:        AppSizes.avatarXL,
              height:       AppSizes.avatarXL,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                border: Border.all(color: Colors.transparent, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                profile['avatar'] as String,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.bgTertiary,
                  child: const Icon(
                    Icons.person,
                    color: AppColors.textSecondary,
                    size:  48,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceSM),
            Text(
              profile['name'] as String,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines:  1,
              overflow:  TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AddProfileTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddProfileTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.avatarXL,
        child: Column(
          children: [
            Container(
              width:  AppSizes.avatarXL,
              height: AppSizes.avatarXL,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                border: Border.all(color: AppColors.textTertiary, width: 2),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.textTertiary,
                size:  40,
              ),
            ),
            const SizedBox(height: AppSizes.spaceSM),
            Text(
              AppStrings.addProfile,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}