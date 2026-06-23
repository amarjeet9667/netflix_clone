// ============================================================
//  app_router.dart
//  lib/core/router/app_router.dart
//
//  GoRouter configuration
//  - Redirect logic (auth guard + profile guard)
//  - Shell route for bottom nav persistence
//  - Slide/fade transitions per route type
// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import 'router_transitions.dart';

// ── Pages ────────────────────────────────────────────────────
import 'package:netflix_clone/features/auth/presentation/pages/splash_page.dart';
import 'package:netflix_clone/features/auth/presentation/pages/onboarding_page.dart';
import 'package:netflix_clone/features/auth/presentation/pages/login_page.dart';
import 'package:netflix_clone/features/auth/presentation/pages/register_page.dart';
import 'package:netflix_clone/features/auth/presentation/pages/forgot_password_page.dart';

import 'package:netflix_clone/features/user/presentation/pages/who_is_watching_page.dart';
import 'package:netflix_clone/features/user/presentation/pages/manage_profiles_page.dart';
import 'package:netflix_clone/features/user/presentation/pages/edit_profile_page.dart';
import 'package:netflix_clone/features/user/presentation/pages/account_page.dart';
import 'package:netflix_clone/features/user/presentation/pages/settings_page.dart';

import 'package:netflix_clone/features/home/presentation/pages/home_page.dart';
import 'package:netflix_clone/features/movies/presentation/pages/movies_page.dart';
import 'package:netflix_clone/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:netflix_clone/features/tv_shows/presentation/pages/tvshows_page.dart';
import 'package:netflix_clone/features/tv_shows/presentation/pages/season_detail_page.dart';
import 'package:netflix_clone/features/search/presentation/pages/search_page.dart';
import 'package:netflix_clone/features/downloads/presentation/pages/downloads_page.dart';
import 'package:netflix_clone/features/watchlist/presentation/pages/my_list_page.dart';
import 'package:netflix_clone/features/notifications/presentation/pages/notifications_page.dart';
import 'package:netflix_clone/features/player/presentation/pages/player_page.dart';

// ── Shell scaffold (bottom nav) ──────────────────────────────
import 'package:netflix_clone/shared/widgets/main_shell.dart';

class AppRouter {
  AppRouter._();

  // Simple in-memory auth state — replace with AuthBloc stream
  static bool _isLoggedIn       = false;
  static bool _hasPickedProfile = false;

  static void setLoggedIn(bool v)       => _isLoggedIn = v;
  static void setProfilePicked(bool v)  => _hasPickedProfile = v;

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,

    // ── Auth redirect guard ───────────────────────────────
    redirect: (BuildContext context, GoRouterState state) {
      final path = state.matchedLocation;

      final isAuthRoute = path == RouteNames.login     ||
                          path == RouteNames.register  ||
                          path == RouteNames.onboarding||
                          path == RouteNames.splash    ||
                          path == RouteNames.forgotPass;

      if (!_isLoggedIn && !isAuthRoute) return RouteNames.login;
      if (_isLoggedIn && !_hasPickedProfile &&
          path != RouteNames.whoIsWatching) {
        return RouteNames.whoIsWatching;
      }
      if (_isLoggedIn && isAuthRoute &&
          path != RouteNames.splash) return RouteNames.home;

      return null; // no redirect
    },

    routes: [
      // ── Splash ─────────────────────────────────────────
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        pageBuilder: (context, state) => RouterTransitions.fade(
          state: state,
          child: const SplashPage(),
        ),
      ),

      // ── Onboarding ─────────────────────────────────────
      GoRoute(
        path: RouteNames.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const OnboardingPage(),
        ),
      ),

      // ── Auth ───────────────────────────────────────────
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        pageBuilder: (context, state) => RouterTransitions.fade(
          state: state,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const RegisterPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.forgotPass,
        name: 'forgotPassword',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const ForgotPasswordPage(),
        ),
      ),

      // ── Profile picker ─────────────────────────────────
      GoRoute(
        path: RouteNames.whoIsWatching,
        name: 'whoIsWatching',
        pageBuilder: (context, state) => RouterTransitions.fade(
          state: state,
          child: const WhoIsWatchingPage(),
        ),
        routes: [
          GoRoute(
            path: 'manage',
            name: 'manageProfiles',
            pageBuilder: (context, state) => RouterTransitions.slide(
              state: state,
              child: const ManageProfilesPage(),
            ),
          ),
          GoRoute(
            path: 'edit',
            name: 'editProfile',
            pageBuilder: (context, state) => RouterTransitions.slide(
              state: state,
              child: const EditProfilePage(),
            ),
          ),
        ],
      ),

      // ── Main shell with bottom nav ──────────────────────
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            name: 'home',
            pageBuilder: (context, state) => RouterTransitions.noTransition(
              state: state,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: RouteNames.tvShows,
            name: 'tvShows',
            pageBuilder: (context, state) => RouterTransitions.noTransition(
              state: state,
              child: const TVShowsPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.movies,
            name: 'movies',
            pageBuilder: (context, state) => RouterTransitions.noTransition(
              state: state,
              child: const MoviesPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.search,
            name: 'search',
            pageBuilder: (context, state) => RouterTransitions.noTransition(
              state: state,
              child: const SearchPage(),
            ),
          ),
          GoRoute(
            path: RouteNames.downloads,
            name: 'downloads',
            pageBuilder: (context, state) => RouterTransitions.noTransition(
              state: state,
              child: const DownloadsPage(),
            ),
          ),
        ],
      ),

      // ── Detail pages (full screen, outside shell) ───────
      GoRoute(
        path: RouteNames.movieDetail,
        name: 'movieDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return RouterTransitions.slideUp(
            state: state,
            child: MovieDetailPage(movieId: id),
          );
        },
      ),

      GoRoute(
        path: RouteNames.showDetail,
        name: 'showDetail',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return RouterTransitions.slideUp(
            state: state,
            child: TVShowsPage(showId: id),
          );
        },
        routes: [
          GoRoute(
            path: 'season/:seasonNumber',
            name: 'seasonDetail',
            pageBuilder: (context, state) {
              final id     = state.pathParameters['id']!;
              final season = int.parse(state.pathParameters['seasonNumber']!);
              return RouterTransitions.slide(
                state: state,
                child: SeasonDetailPage(showId: id, seasonNumber: season),
              );
            },
          ),
        ],
      ),

      // ── Player (full screen, no nav, no transition anim) ─
      GoRoute(
        path: RouteNames.player,
        name: 'player',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return RouterTransitions.noTransition(
            state: state,
            child: PlayerPage(contentId: id),
          );
        },
      ),

      // ── User / Account ──────────────────────────────────
      GoRoute(
        path: RouteNames.account,
        name: 'account',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const AccountPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: 'settings',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const SettingsPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.myList,
        name: 'myList',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const MyListPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.notifications,
        name: 'notifications',
        pageBuilder: (context, state) => RouterTransitions.slide(
          state: state,
          child: const NotificationsPage(),
        ),
      ),
    ],
  );
}