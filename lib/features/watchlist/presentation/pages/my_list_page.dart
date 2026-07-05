// lib/features/watchlist/presentation/pages/my_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netflix_clone/core/constants/app_colors.dart';
import 'package:netflix_clone/core/constants/app_sizes.dart';
import 'package:netflix_clone/core/constants/app_text_style.dart';
import 'package:netflix_clone/core/constants/app_strings.dart';
import 'package:netflix_clone/core/router/route_names.dart';
import '../bloc/watchlist_bloc.dart';
import '../../domain/entities/watchlist_entity.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(const WatchlistFetchEvent());
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
        title: Text(AppStrings.myList, style: AppTextStyles.titleLarge),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.netflixRed),
            );
          }

          if (state is WatchlistError) {
            return Center(
              child: Text(
                state.message,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            );
          }

          final items = state is WatchlistLoaded
              ? state.myList
              : state is WatchlistItemToggled
                  ? state.myList
                  : <WatchlistEntity>[];

          if (items.isEmpty) {
            return Center(
              child: Text(AppStrings.emptyMyList,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSizes.spaceMD),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   3,
              crossAxisSpacing: AppSizes.spaceXS,
              mainAxisSpacing:  AppSizes.spaceXS,
              childAspectRatio: 0.67,
            ),
            itemCount:   items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return GestureDetector(
                onTap: () => context.go(
                  RouteNames.movieDetailPath(item.contentId),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                  child: item.posterUrl != null
                      ? Image.network(
                          item.posterUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: AppColors.bgTertiary),
                        )
                      : Container(color: AppColors.bgTertiary),
                ),
              );
            },
          );
        },
      ),
    );
  }
}