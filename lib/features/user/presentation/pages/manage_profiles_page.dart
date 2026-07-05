// lib/features/user/presentation/pages/manage_profiles_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../../domain/entities/profile_entity.dart';
import '../bloc/profile_bloc.dart';

class ManageProfilesPage extends StatefulWidget {
  const ManageProfilesPage({super.key});
  @override
  State<ManageProfilesPage> createState() => _ManageProfilesPageState();
}

class _ManageProfilesPageState extends State<ManageProfilesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileFetchAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Cancel',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        title: Text(AppStrings.manageProfiles, style: AppTextStyles.titleLarge),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Done',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileDeleted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile deleted')));
          }
          if (state is ProfileSaved) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Profile saved')));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.netflixRed),
            );
          }

          final profiles = state is ProfileListLoaded
              ? state.profiles
              : state is ProfileDeleted
              ? state.remaining
              : <ProfileEntity>[];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.spaceXL),
            child: Column(
              children: [
                const SizedBox(height: AppSizes.spaceXL),
                Wrap(
                  spacing: AppSizes.spaceXXL,
                  runSpacing: AppSizes.spaceXXL,
                  alignment: WrapAlignment.center,
                  children: [
                    ...profiles.map(
                      (p) => _EditableProfileTile(
                        profile: p,
                        onTap: () => context.go(RouteNames.editProfile),
                      ),
                    ),
                    if (profiles.length < 5)
                      _AddTile(onTap: () => context.go(RouteNames.editProfile)),
                  ],
                ),
                const SizedBox(height: AppSizes.space4XL),
                Text(
                  'Tap a profile to edit or delete it.',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EditableProfileTile extends StatelessWidget {
  final ProfileEntity profile;
  final VoidCallback onTap;
  const _EditableProfileTile({required this.profile, required this.onTap});

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
                  width: AppSizes.avatarXL,
                  height: AppSizes.avatarXL,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    profile.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.bgTertiary,
                      child: const Icon(
                        Icons.person,
                        color: AppColors.textSecondary,
                        size: 48,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.bgTertiary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgPrimary, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: AppColors.textPrimary,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSM),
            Text(
              profile.name,
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
              width: AppSizes.avatarXL,
              height: AppSizes.avatarXL,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                border: Border.all(color: AppColors.textTertiary, width: 2),
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.textTertiary,
                size: 40,
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
