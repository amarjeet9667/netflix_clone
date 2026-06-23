// ============================================================
//  route_names.dart
//  lib/core/router/route_names.dart
//
//  Single source of truth for every named route path
//  Use RouteNames.X everywhere — never hardcode '/path'
// ============================================================

class RouteNames {
  RouteNames._();

  // ── Splash / Onboarding ──────────────────────────────────
  static const String splash      = '/';
  static const String onboarding  = '/onboarding';

  // ── Auth ─────────────────────────────────────────────────
  static const String login       = '/login';
  static const String register    = '/register';
  static const String forgotPass  = '/forgot-password';

  // ── Profile picker (after login, before home) ────────────
  static const String whoIsWatching = '/who-is-watching';
  static const String manageProfiles= '/manage-profiles';
  static const String editProfile   = '/edit-profile';

  // ── Main shell (bottom nav) ──────────────────────────────
  static const String home        = '/home';
  static const String tvShows     = '/tv-shows';
  static const String movies      = '/movies';
  static const String search      = '/search';
  static const String downloads   = '/downloads';

  // ── Detail pages ─────────────────────────────────────────
  static const String movieDetail = '/movie/:id';
  static const String showDetail  = '/show/:id';
  static const String seasonDetail= '/show/:id/season/:seasonNumber';

  // ── Player ───────────────────────────────────────────────
  static const String player      = '/player/:id';

  // ── User ─────────────────────────────────────────────────
  static const String account     = '/account';
  static const String settings    = '/settings';
  static const String myList      = '/my-list';
  static const String notifications = '/notifications';

  // ── Helpers: build paths with params ─────────────────────
  static String movieDetailPath(String id)  => '/movie/$id';
  static String showDetailPath(String id)   => '/show/$id';
  static String seasonDetailPath(String id, int season)
                                            => '/show/$id/season/$season';
  static String playerPath(String id)       => '/player/$id';
}