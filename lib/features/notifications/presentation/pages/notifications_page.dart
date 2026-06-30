// lib/features/notifications/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../../domain/entities/notification_entity.dart';
import '../bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Fixed: trigger BLoC fetch on open instead of reading dummy data directly
    context.read<NotificationBloc>().add(const NotificationFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary, size: AppSizes.iconMD),
          onPressed: () => context.pop(),
        ),
        title: Text(AppStrings.notificationsTitle,
            style: AppTextStyles.titleLarge),
        actions: [
          // ✅ Fixed: wires to BLoC instead of no-op
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is! NotificationLoaded) return const SizedBox.shrink();
              if (!state.hasUnread)             return const SizedBox.shrink();
              return TextButton(
                onPressed: () => context
                    .read<NotificationBloc>()
                    .add(const NotificationMarkAllReadEvent()),
                child: Text(
                  AppStrings.markAllRead,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          // ── Loading ──────────────────────────────────────
          if (state is NotificationLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: AppColors.netflixRed),
            );
          }

          // ── Error ────────────────────────────────────────
          if (state is NotificationError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.notifications_off_outlined,
                      color: AppColors.textTertiary, size: 56),
                  const SizedBox(height: AppSizes.spaceMD),
                  Text(state.message,
                      style: AppTextStyles.bodyMedium),
                  const SizedBox(height: AppSizes.spaceMD),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.netflixRed),
                    onPressed: () => context
                        .read<NotificationBloc>()
                        .add(const NotificationFetchEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ── Loaded ───────────────────────────────────────
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.notifications_none,
                        color: AppColors.textTertiary, size: 64),
                    const SizedBox(height: AppSizes.spaceMD),
                    Text(AppStrings.noNotifications,
                        style: AppTextStyles.bodyMedium),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: state.notifications.length,
              separatorBuilder: (_, __) => const Divider(
                  color: AppColors.divider, height: 1),
              itemBuilder: (context, i) {
                final n = state.notifications[i];
                return _NotificationTile(
                  notification: n,
                  // ✅ Fixed: tap marks as read via BLoC
                  onTap: () {
                    if (!n.isRead) {
                      context.read<NotificationBloc>().add(
                        NotificationMarkReadEvent(
                            notificationId: n.id),
                      );
                    }
                    if (n.contentId != null) {
                      context.go(
                        RouteNames.movieDetailPath(
                            n.contentId.toString()),
                      );
                    }
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ── Notification tile ─────────────────────────────────────────
class _NotificationTile extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback       onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final n      = notification;
    final isRead = n.isRead;

    return InkWell(
      onTap:     onTap,
      child: Container(
        color: isRead ? null : AppColors.white10,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMD,
          vertical:   AppSizes.spaceMD,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
              child: SizedBox(
                width: 80, height: 56,
                child: Image.network(
                  n.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: AppColors.bgTertiary),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceMD),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + unread dot
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          n.title,
                          style: AppTextStyles.labelLarge.copyWith(
                            color: isRead
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (!isRead) ...[
                        const SizedBox(width: AppSizes.spaceXS),
                        Container(
                          width:  8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.netflixRed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceXXS),

                  // Body
                  Text(
                    n.body,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceXXS),

                  // Time ago + type badge
                  Row(
                    children: [
                      Text(n.timeAgo,
                          style: AppTextStyles.micro),
                      const SizedBox(width: AppSizes.spaceXS),
                      _TypeBadge(type: n.type),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Notification type badge ───────────────────────────────────
class _TypeBadge extends StatelessWidget {
  final NotificationType type;
  const _TypeBadge({required this.type});

  String get _label {
    switch (type) {
      case NotificationType.newEpisode:    return 'New Episode';
      case NotificationType.newRelease:    return 'New';
      case NotificationType.reminder:      return 'Reminder';
      case NotificationType.recommendation:return 'For You';
      case NotificationType.accountAlert:  return 'Account';
    }
  }

  Color get _color {
    switch (type) {
      case NotificationType.newEpisode:    return AppColors.netflixRed;
      case NotificationType.newRelease:    return AppColors.success;
      case NotificationType.reminder:      return AppColors.warning;
      case NotificationType.recommendation:return AppColors.info;
      case NotificationType.accountAlert:  return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceXXS + 2,
        vertical:   1,
      ),
      decoration: BoxDecoration(
        color:        _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusXS),
        border:       Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        _label,
        style: AppTextStyles.micro.copyWith(color: _color),
      ),
    );
  }
}