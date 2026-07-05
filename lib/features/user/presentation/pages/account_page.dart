// lib/features/user/presentation/pages/account_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/features/auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: AppSizes.iconMD,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'NETFLIX',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.netflixRed,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profile = state is ProfileActive ? state.activeProfile : null;

          return ListView(
            padding: const EdgeInsets.all(AppSizes.spaceMD),
            children: [
              // ── Profile header ─────────────────────────────
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    child: profile != null
                        ? Image.network(
                            profile.avatarUrl,
                            width: AppSizes.avatarMD,
                            height: AppSizes.avatarMD,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: AppSizes.avatarMD,
                              height: AppSizes.avatarMD,
                              color: AppColors.bgTertiary,
                              child: const Icon(
                                Icons.person,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          )
                        : Container(
                            width: AppSizes.avatarMD,
                            height: AppSizes.avatarMD,
                            color: AppColors.bgTertiary,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                            ),
                          ),
                  ),
                  const SizedBox(width: AppSizes.spaceMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile?.name ?? 'My Profile',
                          style: AppTextStyles.titleSmall,
                        ),
                        Text(
                          profile?.maturityRating ?? '',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.whoIsWatching),
                    child: Text(
                      'Switch Profiles',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textLink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceXL),
              const Divider(color: AppColors.divider),

              // ── Menu sections ──────────────────────────────
              _Section(
                title: 'Account',
                items: [
                  _MenuItem(
                    icon: Icons.credit_card_outlined,
                    label: AppStrings.membership,
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.phone_android_outlined,
                    label: AppStrings.planDetails,
                    onTap: () {},
                  ),
                ],
              ),
              _Section(
                title: 'Settings',
                items: [
                  _MenuItem(
                    icon: Icons.settings_outlined,
                    label: AppStrings.appSettings,
                    onTap: () => context.go(RouteNames.settings),
                  ),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: AppStrings.notificationsTitle,
                    onTap: () => context.go(RouteNames.notifications),
                  ),
                  _MenuItem(
                    icon: Icons.manage_accounts_outlined,
                    label: AppStrings.manageProfiles,
                    onTap: () => context.go(RouteNames.manageProfiles),
                  ),
                ],
              ),
              _Section(
                title: 'Support',
                items: [
                  _MenuItem(
                    icon: Icons.help_outline,
                    label: AppStrings.helpCenter,
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    label: AppStrings.privacyPolicy,
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: Icons.description_outlined,
                    label: AppStrings.termsOfUse,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceXL),

              // ── Sign out ───────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: AppSizes.btnHeightLG,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.dividerLight),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                    context.go(RouteNames.login);
                  },
                  child: Text(
                    AppStrings.signOut,
                    style: AppTextStyles.btnSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceMD),
              Center(
                child: Text('Netflix Clone v1.0.0', style: AppTextStyles.micro),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _Section({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceMD),
          child: Text(title, style: AppTextStyles.labelMedium),
        ),
        ...items,
        const Divider(color: AppColors.divider),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: AppColors.textSecondary,
        size: AppSizes.iconLG,
      ),
      title: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
        size: AppSizes.iconLG,
      ),
      onTap: onTap,
    );
  }
}
