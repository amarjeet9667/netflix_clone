// lib/features/user/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/config/app_config.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoPlayNext = true;
  bool _autoPlayPreview = true;
  bool _wifiOnly = true;
  bool _notifications = true;
  String _streamQuality = 'Auto';
  String _downloadQuality = 'Standard';
  String _language = 'English';

  static const _streamOptions = ['Auto', 'Low', 'Medium', 'High', '4K'];
  static const _downloadOptions = ['Standard', 'High'];
  static const _languageOptions = [
    'English',
    'Hindi',
    'Spanish',
    'French',
    'Korean',
  ];

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
        title: Text(AppStrings.appSettings, style: AppTextStyles.titleLarge),
      ),
      body: ListView(
        children: [
          // ── Playback ──────────────────────────────────────
          _SectionHeader('Playback'),
          _SwitchTile(
            title: 'Autoplay Next Episode',
            subtitle: 'Automatically play next episode in a series.',
            value: _autoPlayNext,
            onChanged: (v) => setState(() => _autoPlayNext = v),
          ),
          _SwitchTile(
            title: 'Autoplay Previews',
            subtitle: 'Preview content while you browse.',
            value: _autoPlayPreview,
            onChanged: (v) => setState(() => _autoPlayPreview = v),
          ),
          _ChevronTile(
            title: 'Streaming Quality',
            subtitle: _streamQuality,
            onTap: () => _showPicker(
              context,
              title: 'Streaming Quality',
              options: _streamOptions,
              selected: _streamQuality,
              onSelect: (v) => setState(() => _streamQuality = v),
            ),
          ),
          const Divider(color: AppColors.divider),

          // ── Downloads ─────────────────────────────────────
          _SectionHeader('Downloads'),
          _SwitchTile(
            title: 'Wi-Fi Only',
            subtitle: 'Download content only on Wi-Fi.',
            value: _wifiOnly,
            onChanged: (v) => setState(() => _wifiOnly = v),
          ),
          _ChevronTile(
            title: 'Download Quality',
            subtitle: _downloadQuality,
            onTap: () => _showPicker(
              context,
              title: 'Download Quality',
              options: _downloadOptions,
              selected: _downloadQuality,
              onSelect: (v) => setState(() => _downloadQuality = v),
            ),
          ),
          const Divider(color: AppColors.divider),

          // ── Notifications ─────────────────────────────────
          _SectionHeader('Notifications'),
          _SwitchTile(
            title: 'Push Notifications',
            subtitle: 'Alerts for new episodes and recommendations.',
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          const Divider(color: AppColors.divider),

          // ── Language ──────────────────────────────────────
          _SectionHeader('Language'),
          _ChevronTile(
            title: 'App Language',
            subtitle: _language,
            onTap: () => _showPicker(
              context,
              title: 'App Language',
              options: _languageOptions,
              selected: _language,
              onSelect: (v) => setState(() => _language = v),
            ),
          ),
          const Divider(color: AppColors.divider),

          // ── About ─────────────────────────────────────────
          _SectionHeader('About'),
          _ChevronTile(
            title: 'App Version',
            subtitle: '${AppConfig.appVersion} (${AppConfig.buildNumber})',
            onTap: () {},
          ),
          _ChevronTile(
            title: 'Clear App Cache',
            subtitle: 'Frees up storage space.',
            onTap: () => _confirmClearCache(context),
          ),
          const SizedBox(height: AppSizes.space5XL),
        ],
      ),
    );
  }

  void _showPicker(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgModal,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusXL),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.spaceMD,
          AppSizes.spaceXL,
          AppSizes.spaceMD,
          AppSizes.spaceXXL,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: AppSizes.sheetHandleW,
                height: AppSizes.sheetHandleH,
                decoration: BoxDecoration(
                  color: AppColors.dividerLight,
                  borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceMD),
            Text(title, style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSizes.spaceSM),
            ...options.map(
              (opt) => ListTile(
                title: Text(
                  opt,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: opt == selected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                trailing: opt == selected
                    ? const Icon(
                        Icons.check,
                        color: AppColors.netflixRed,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  onSelect(opt);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmClearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgModal,
        title: Text('Clear Cache?', style: AppTextStyles.titleMedium),
        content: Text(
          'Clears temporary files. Downloads are not affected.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Clear',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.netflixRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSizes.spaceMD,
      AppSizes.spaceXL,
      AppSizes.spaceMD,
      AppSizes.spaceXS,
    ),
    child: Text(title, style: AppTextStyles.labelMedium),
  );
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(
      title,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
    ),
    subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.netflixRed,
    ),
  );
}

class _ChevronTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ChevronTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(
      title,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
    ),
    subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
    trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
    onTap: onTap,
  );
}
