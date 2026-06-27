// lib/features/user/presentation/pages/edit_profile_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameCtrl   = TextEditingController(text: 'Emily');
  bool  _isKids     = false;
  String _maturity  = 'All Maturity Ratings';
  int   _selectedAvatar = 0;

  static const _avatars = [
    'https://dummyjson.com/icon/emilys/128',
    'https://dummyjson.com/icon/michaelw/128',
    'https://dummyjson.com/icon/sophiab/128',
    'https://dummyjson.com/icon/jamesd/128',
    'https://dummyjson.com/icon/emmaj/128',
    'https://dummyjson.com/icon/oliviaw/128',
  ];

  @override
  void dispose() { _nameCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: TextButton(
          onPressed: () => context.pop(),
          child: Text('Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              )),
        ),
        title: Text(AppStrings.editProfile,
            style: AppTextStyles.titleLarge),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(AppStrings.profileSaved,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceXL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar selector
            Center(
              child: Stack(
                children: [
                  Container(
                    width:        AppSizes.avatarXL,
                    height:       AppSizes.avatarXL,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      _avatars[_selectedAvatar],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.bgTertiary,
                        child: const Icon(Icons.person,
                            color: AppColors.textSecondary, size: 48),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0, bottom: 0,
                    child: Container(
                      width:  32,
                      height: 32,
                      decoration: BoxDecoration(
                        color:  AppColors.bgSecondary,
                        shape:  BoxShape.circle,
                        border: Border.all(
                            color: AppColors.bgPrimary, width: 2),
                      ),
                      child: const Icon(Icons.edit,
                          color: AppColors.textPrimary, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),

            // Avatar picker
            Text('Choose Avatar', style: AppTextStyles.labelMedium),
            const SizedBox(height: AppSizes.spaceXS),
            SizedBox(
              height: 64,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:       _avatars.length,
                itemBuilder: (_, i) {
                  final selected = i == _selectedAvatar;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAvatar = i),
                    child: Container(
                      width:  56,
                      height: 56,
                      margin: const EdgeInsets.only(
                          right: AppSizes.spaceXS),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            AppSizes.radiusSM),
                        border: Border.all(
                          color: selected
                              ? AppColors.textPrimary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        _avatars[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.bgTertiary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSizes.spaceXL),

            // Name field
            Text(AppStrings.profileName,
                style: AppTextStyles.labelMedium),
            const SizedBox(height: AppSizes.spaceXS),
            TextField(
              controller:  _nameCtrl,
              style:       AppTextStyles.inputText,
              cursorColor: AppColors.textPrimary,
              decoration: InputDecoration(
                filled:      true,
                fillColor:   AppColors.inputBg,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.inputRadius),
                  borderSide:
                      const BorderSide(color: AppColors.inputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.inputRadius),
                  borderSide:
                      const BorderSide(color: AppColors.inputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.inputRadius),
                  borderSide: const BorderSide(
                    color: AppColors.inputBorderFocus, width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceXL),
            const Divider(color: AppColors.divider),

            // Maturity settings
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(AppStrings.maturitySettings,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  )),
              subtitle: Text(_maturity,
                  style: AppTextStyles.bodySmall),
              trailing: const Icon(Icons.chevron_right,
                  color: AppColors.textTertiary),
              onTap: () {},
            ),
            const Divider(color: AppColors.divider),

            // Kids profile toggle
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(AppStrings.kidsProfile,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  )),
              subtitle: Text(
                'Shows only kid-friendly content.',
                style: AppTextStyles.bodySmall,
              ),
              trailing: Switch(
                value:        _isKids,
                onChanged:    (v) => setState(() => _isKids = v),
                activeColor:  AppColors.netflixRed,
              ),
            ),
            const Divider(color: AppColors.divider),
            const SizedBox(height: AppSizes.space3XL),

            // Delete profile
            Center(
              child: TextButton(
                onPressed: () => _confirmDelete(context),
                child: Text(
                  AppStrings.deleteProfile,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor:  AppColors.bgModal,
        title: Text('Delete Profile?',
            style: AppTextStyles.titleMedium),
        content: Text(
          'This profile and all its settings will be permanently deleted.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                )),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: Text('Delete',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.netflixRed,
                )),
          ),
        ],
      ),
    );
  }
}