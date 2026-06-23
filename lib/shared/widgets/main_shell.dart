// ============================================================
//  main_shell.dart
//  lib/shared/widgets/main_shell.dart
//
//  ShellRoute scaffold — persists bottom nav across tab switches
//  Receives child from GoRouter ShellRoute
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/shared/cubit/bottom_nav_cubit.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  static const List<_NavItem> _items = [
    _NavItem(
      label:       AppStrings.navHome,
      icon:        Icons.home_outlined,
      activeIcon:  Icons.home,
      route:       RouteNames.home,
    ),
    _NavItem(
      label:       AppStrings.navTvShows,
      icon:        Icons.tv_outlined,
      activeIcon:  Icons.tv,
      route:       RouteNames.tvShows,
    ),
    _NavItem(
      label:       AppStrings.navMovies,
      icon:        Icons.movie_outlined,
      activeIcon:  Icons.movie,
      route:       RouteNames.movies,
    ),
    _NavItem(
      label:       AppStrings.navSearch,
      icon:        Icons.search_outlined,
      activeIcon:  Icons.search,
      route:       RouteNames.search,
    ),
    _NavItem(
      label:       AppStrings.navDownloads,
      icon:        Icons.download_outlined,
      activeIcon:  Icons.download,
      route:       RouteNames.downloads,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          backgroundColor: AppColors.bgPrimary,
          body:            child,
          bottomNavigationBar: _NetflixBottomNav(
            currentIndex: currentIndex,
            items:        _items,
            onTap: (index) {
              context.read<BottomNavCubit>().setIndex(index);
              context.go(_items[index].route);
            },
          ),
        );
      },
    );
  }
}

// ── Bottom nav bar widget ─────────────────────────────────────
class _NetflixBottomNav extends StatelessWidget {
  final int                currentIndex;
  final List<_NavItem>     items;
  final ValueChanged<int>  onTap;

  const _NetflixBottomNav({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:     AppSizes.bottomNavH + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: AppColors.bgPrimary,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: AppSizes.dividerH),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final item      = items[i];
            final isActive  = i == currentIndex;
            return _NavTab(
              item:     item,
              isActive: isActive,
              onTap:    () => onTap(i),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final _NavItem item;
  final bool     isActive;
  final VoidCallback onTap;

  const _NavTab({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? AppColors.navIconActive
        : AppColors.navIconInactive;

    return GestureDetector(
      onTap:     onTap,
      behavior:  HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Netflix logo "N" for Home tab
            if (item.route == RouteNames.home)
              _NetflixNLogo(isActive: isActive)
            else
              Icon(
                isActive ? item.activeIcon : item.icon,
                color: color,
                size:  AppSizes.bottomNavIconH,
              ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize:   10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color:      color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Netflix "N" logo for home tab (matches real Netflix app)
class _NetflixNLogo extends StatelessWidget {
  final bool isActive;
  const _NetflixNLogo({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 24,
      child: CustomPaint(
        painter: _NLogoPainter(
          color: isActive ? AppColors.netflixRed : AppColors.navIconInactive,
        ),
      ),
    );
  }
}

class _NLogoPainter extends CustomPainter {
  final Color color;
  const _NLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color     = color
      ..style     = PaintingStyle.fill
      ..strokeWidth = 3;

    final w = size.width;
    final h = size.height;

    // Left bar
    canvas.drawRect(Rect.fromLTWH(0, 0, w * 0.22, h), paint);
    // Right bar
    canvas.drawRect(Rect.fromLTWH(w * 0.78, 0, w * 0.22, h), paint);
    // Diagonal
    final path = Path()
      ..moveTo(0,        0)
      ..lineTo(w * 0.22, 0)
      ..lineTo(w,        h)
      ..lineTo(w * 0.78, h)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NLogoPainter old) => old.color != color;
}

// ── Data class ────────────────────────────────────────────────
class _NavItem {
  final String  label;
  final IconData icon;
  final IconData activeIcon;
  final String  route;
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
}