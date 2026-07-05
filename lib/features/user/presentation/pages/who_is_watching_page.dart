// lib/features/user/presentation/pages/who_is_watching_page.dart
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

class WhoIsWatchingPage extends StatefulWidget {
  const WhoIsWatchingPage({super.key});
  @override
  State<WhoIsWatchingPage> createState() => _WhoIsWatchingPageState();
}

class _WhoIsWatchingPageState extends State<WhoIsWatchingPage> {
  @override
  void initState() {
    super.initState();
    // ✅ BLoC-driven fetch
    context.read<ProfileBloc>().add(const ProfileFetchAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            // Navigate to home once a profile is selected
            if (state is ProfileActive) {
              context.go(RouteNames.home);
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.netflixRed),
              );
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.textTertiary,
                      size: 56,
                    ),
                    const SizedBox(height: AppSizes.spaceMD),
                    Text(state.message, style: AppTextStyles.bodyMedium),
                    const SizedBox(height: AppSizes.spaceMD),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.netflixRed,
                      ),
                      onPressed: () => context.read<ProfileBloc>().add(
                        const ProfileFetchAllEvent(),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final profiles = state is ProfileListLoaded
                ? state.profiles
                : <ProfileEntity>[];

            return Column(
              children: [
                // ── Top bar ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.screenPaddingH,
                    vertical: AppSizes.spaceXL,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NETFLIX',
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.netflixRed,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go(RouteNames.manageProfiles),
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

                Text(
                  AppStrings.whoIsWatching,
                  style: AppTextStyles.headlineMedium,
                ),
                const SizedBox(height: AppSizes.space3XL),

                // ── Profile grid ───────────────────────────
                Wrap(
                  spacing: AppSizes.spaceXL,
                  runSpacing: AppSizes.spaceXL,
                  alignment: WrapAlignment.center,
                  children: [
                    ...profiles.map(
                      (p) => _ProfileTile(
                        profile: p,
                        onTap: () => context.read<ProfileBloc>().add(
                          ProfileSelectEvent(profileId: p.id),
                        ),
                      ),
                    ),
                    if (profiles.length < 5)
                      _AddProfileTile(
                        onTap: () => context.go(RouteNames.editProfile),
                      ),
                  ],
                ),

                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final ProfileEntity profile;
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
            const SizedBox(height: AppSizes.spaceSM),
            Text(
              profile.name,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            if (profile.isKids)
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.spaceXXS),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textTertiary),
                    borderRadius: BorderRadius.circular(AppSizes.radiusXS),
                  ),
                  child: Text(
                    AppStrings.kidsProfile,
                    style: AppTextStyles.micro,
                  ),
                ),
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
