// lib/features/notifications/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final notifs = DummyNotifications.notifications;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        title: Text(AppStrings.notificationsTitle,
            style: AppTextStyles.titleLarge),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(AppStrings.markAllRead,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                )),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount:   notifs.length,
        separatorBuilder: (_, __) =>
            const Divider(color: AppColors.divider, height: 1),
        itemBuilder: (context, i) {
          final n       = notifs[i];
          final isRead  = n['isRead'] as bool;
          return Container(
            color: isRead ? null : AppColors.white10,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.spaceMD,
                vertical:   AppSizes.spaceXS,
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                child: SizedBox(
                  width: 64, height: 40,
                  child: Image.network(
                    n['imageUrl'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(color: AppColors.bgTertiary),
                  ),
                ),
              ),
              title: Text(n['title'] as String,
                  style: AppTextStyles.labelLarge),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: AppSizes.spaceXXS),
                child: Text(n['body'] as String,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
              trailing: isRead
                  ? null
                  : Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color:  AppColors.netflixRed,
                        shape:  BoxShape.circle,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}