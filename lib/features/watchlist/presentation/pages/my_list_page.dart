// lib/features/watchlist/presentation/pages/my_list_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final items = DummyWatchlist.items;
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.bgPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary, size: AppSizes.iconMD),
          onPressed: () => context.pop(),
        ),
        title: Text(AppStrings.myList, style: AppTextStyles.titleLarge),
      ),
      body: items.isEmpty
          ? Center(
              child: Text(AppStrings.emptyMyList,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSizes.spaceMD),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   3,
                crossAxisSpacing: AppSizes.spaceXS,
                mainAxisSpacing:  AppSizes.spaceXS,
                childAspectRatio: 0.67,
              ),
              itemCount:   items.length,
              itemBuilder: (context, i) {
                final content = items[i]['content'] as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () => context.go(
                    RouteNames.movieDetailPath(content['id'].toString()),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                    child: Image.network(
                      content['posterUrl'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: AppColors.bgTertiary),
                    ),
                  ),
                );
              },
            ),
    );
  }
}