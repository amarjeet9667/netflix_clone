// lib/features/user/presentation/pages/manage_profiles_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class ManageProfilesPage extends StatelessWidget {
  const ManageProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = DummyUsers.profiles;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.close,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(AppStrings.manageProfiles,
            style: AppTextStyles.titleLarge),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Done',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spaceXL),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceXL),

            // Profile grid
            Wrap(
              spacing:    AppSizes.spaceXXL,
              runSpacing: AppSizes.spaceXXL,
              alignment:  WrapAlignment.center,
              children: [
                ...profiles.map(
                  (p) => _EditableProfileTile(
                    profile: p,
                    onTap: () => context.go(
                      '${Uri.base.path}/edit',
                    ),
                  ),
                ),
                // Add profile
                if (profiles.length < 5)
                  _AddTile(
                    onTap: () => context.go(
                      '${Uri.base.path}/edit',
                    ),
                  ),
              ],
            ),

            const SizedBox(height: AppSizes.space4XL),

            // Delete profiles hint
            Text(
              'Tap a profile to edit or delete it.',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditableProfileTile extends StatelessWidget {
  final Map<String, dynamic> profile;
  final VoidCallback         onTap;
  const _EditableProfileTile({
    required this.profile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: AppSizes.avatarXL,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width:        AppSizes.avatarXL,
                  height:       AppSizes.avatarXL,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    profile['avatar'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.bgTertiary,
                      child: const Icon(Icons.person,
                          color: AppColors.textSecondary,
                          size: 48),
                    ),
                  ),
                ),
                // Edit pencil overlay
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width:  28,
                    height: 28,
                    decoration: BoxDecoration(
                      color:  AppColors.bgTertiary,
                      shape:  BoxShape.circle,
                      border: Border.all(
                        color: AppColors.bgPrimary, width: 2,
                      ),
                    ),
                    child: const Icon(Icons.edit,
                        color: AppColors.textPrimary, size: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSM),
            Text(
              profile['name'] as String,
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

class _AddTile extends StatelessWidget {
  final VoidCallback onTap;
  const _AddTile({required this.onTap});

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
                border: Border.all(
                    color: AppColors.textTertiary, width: 2),
              ),
              child: const Icon(Icons.add,
                  color: AppColors.textTertiary, size: 40),
            ),
            const SizedBox(height: AppSizes.spaceSM),
            Text(AppStrings.addProfile,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}