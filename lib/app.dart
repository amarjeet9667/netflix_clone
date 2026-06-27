import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/core/themes/app_theme.dart';
import 'package:netflix_clone/injections/injection_container.dart';

import '../core/config/app_config.dart';
import '../core/router/app_router.dart';

// ── Feature BLoCs ─────────────────────────────────────────────
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/movies/presentation/bloc/movies_bloc/movies_bloc.dart';
import '../features/tv_shows/presentation/bloc/tvshow_bloc.dart';
import '../features/search/presentation/bloc/search_bloc.dart';
import '../features/user/presentation/bloc/profile_bloc.dart';
import '../features/watchlist/presentation/bloc/watchlist_bloc.dart';
import '../features/downloads/presentation/bloc/download_bloc.dart';
import '../features/notifications/presentation/bloc/notification_bloc.dart';
import '../features/player/presentation/bloc/player_bloc.dart';

// ── Shared Cubits ─────────────────────────────────────────────
import '../shared/cubit/bottom_nav_cubit.dart';
import '../shared/cubit/theme_cubit.dart';

class NetflixApp extends StatelessWidget {
  const NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ── Auth ────────────────────────────────────────────
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),

        // ── Home ────────────────────────────────────────────
        BlocProvider<HomeBloc>(
          create: (_) => sl<HomeBloc>(),
        ),

        // ── Movies ──────────────────────────────────────────
        BlocProvider<MoviesBloc>(
          create: (_) => sl<MoviesBloc>(),
        ),

        // ── TV Shows ────────────────────────────────────────
        BlocProvider<TVShowBloc>(
          create: (_) => sl<TVShowBloc>(),
        ),

        // ── Search ──────────────────────────────────────────
        BlocProvider<SearchBloc>(
          create: (_) => sl<SearchBloc>(),
        ),

        // ── Profile ─────────────────────────────────────────
        BlocProvider<ProfileBloc>(
          create: (_) => sl<ProfileBloc>(),
        ),

        // ── Watchlist ───────────────────────────────────────
        BlocProvider<WatchlistBloc>(
          create: (_) => sl<WatchlistBloc>(),
        ),

        // ── Downloads ───────────────────────────────────────
        BlocProvider<DownloadBloc>(
          create: (_) => sl<DownloadBloc>(),
        ),

        // ── Notifications ───────────────────────────────────
        BlocProvider<NotificationBloc>(
          create: (_) => sl<NotificationBloc>(),
        ),

        // ── Player ──────────────────────────────────────────
        BlocProvider<PlayerBloc>(
          create: (_) => sl<PlayerBloc>(),
        ),

        // ── Shared Cubits ───────────────────────────────────
        BlocProvider<BottomNavCubit>(
          create: (_) => sl<BottomNavCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp.router(
            // ── App identity ──────────────────────────────
            title: AppConfig.appName,
            debugShowCheckedModeBanner: AppConfig.showDebugBanner,

            // ── Theme ─────────────────────────────────────
            theme:     AppTheme.darkTheme,   // Netflix is always dark
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,

            // ── Router (GoRouter) ─────────────────────────
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}