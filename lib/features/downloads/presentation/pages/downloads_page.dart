// lib/features/downloads/presentation/pages/downloads_page.dart
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final downloads = DummyDownloads.downloads;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        title: Text(AppStrings.downloadsTitle,
            style: AppTextStyles.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceXS,
        ),
        children: [
          // Smart Downloads banner
          Container(
            padding: const EdgeInsets.all(AppSizes.spaceMD),
            decoration: BoxDecoration(
              color:        AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.downloadGradient,
                  ),
                  child: const Icon(Icons.download_done,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: AppSizes.spaceMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.downloadSmart,
                          style: AppTextStyles.labelLarge),
                      Text('Automatically download next episodes',
                          style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                Switch(
                  value:          true,
                  onChanged:      (_) {},
                  activeColor:    AppColors.netflixRed,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.spaceXL),
          Text('Downloaded', style: AppTextStyles.titleSmall),
          const SizedBox(height: AppSizes.spaceMD),

          ...downloads.map((d) => _DownloadTile(download: d)),
        ],
      ),
    );
  }
}

class _DownloadTile extends StatelessWidget {
  final Map<String, dynamic> download;
  const _DownloadTile({required this.download});

  @override
  Widget build(BuildContext context) {
    final isDone       = download['status'] == 'completed';
    final progress     = (download['progressPercent'] as double?) ?? 1.0;
    final sizeMB       = download['fileSizeMB'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spaceMD),
      child: Row(
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            child: SizedBox(
              width: 100, height: 70,
              child: Image.network(
                download['thumbnailUrl'] as String,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: AppColors.bgTertiary),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceMD),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(download['title'] as String,
                    style: AppTextStyles.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: AppSizes.spaceXXS),
                Text(
                  isDone
                      ? '${download['quality']} • ${sizeMB > 999 ? '${(sizeMB / 1000).toStringAsFixed(1)}GB' : '${sizeMB}MB'}'
                      : '${(progress * 100).round()}% • ${download['quality']}',
                  style: AppTextStyles.bodySmall,
                ),
                if (!isDone) ...[
                  const SizedBox(height: AppSizes.spaceXXS),
                  LinearProgressIndicator(
                    value:            progress,
                    backgroundColor:  AppColors.progressBg,
                    valueColor: const AlwaysStoppedAnimation(AppColors.netflixRed),
                    minHeight: AppSizes.progressBarH,
                  ),
                ],
                if (isDone) ...[
                  const SizedBox(height: AppSizes.spaceXXS),
                  Text(
                    '${AppStrings.downloadExpires} ${download['expiresAt']?.toString().split('T').first ?? ''}',
                    style: AppTextStyles.micro,
                  ),
                ],
              ],
            ),
          ),

          // Actions
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert,
                color: AppColors.textSecondary),
            color:    AppColors.bgModal,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'delete',
                child: Text(AppStrings.downloadDelete,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    )),
              ),
              if (!isDone)
                PopupMenuItem(
                  value: 'cancel',
                  child: Text(AppStrings.downloadCancel,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                      )),
                ),
            ],
          ),
        ],
      ),
    );
  }
}