// ============================================================
//  AppConstants — Misc magic numbers & app-wide constants
//  Business logic values, limits, keys
// ============================================================

class AppConstants {
  AppConstants._();

  // ── Hive / SharedPrefs storage keys ──────────────────────
  static const String kAuthToken        = 'auth_token';
  static const String kRefreshToken     = 'refresh_token';
  static const String kUserId           = 'user_id';
  static const String kActiveProfileId  = 'active_profile_id';
  static const String kIsLoggedIn       = 'is_logged_in';
  static const String kOnboardingSeen   = 'onboarding_seen';
  static const String kAppLanguage      = 'app_language';
  static const String kDownloadQuality  = 'download_quality';
  static const String kAutoPlayNext     = 'autoplay_next';
  static const String kAutoPlayPreview  = 'autoplay_preview';
  static const String kDownloadOverWifi = 'download_over_wifi_only';
  static const String kWatchlistBox     = 'watchlist_box';
  static const String kDownloadsBox     = 'downloads_box';
  static const String kProgressBox      = 'watch_progress_box';

  // ── Profiles ─────────────────────────────────────────────
  static const int    maxProfiles        = 5;
  static const int    maxProfileNameLen  = 20;

  // ── Pagination ───────────────────────────────────────────
  static const int    pageSize           = 20;
  static const int    initialPage        = 1;

  // ── Search ───────────────────────────────────────────────
  static const int    minSearchLength    = 2;
  static const int    maxSearchHistory   = 10;

  // ── Player ───────────────────────────────────────────────
  static const int    skipIntroSecs      = 85;   // typical intro length
  static const int    seekForwardSecs    = 10;
  static const int    seekBackwardSecs   = 10;
  static const double autoPlayNextAt     = 0.90; // trigger at 90% watched
  static const int    progressSaveIntervalSecs = 30;

  // ── Downloads ────────────────────────────────────────────
  static const int    maxDownloads       = 25;
  static const int    downloadExpiryDays = 30;

  // ── Image / Aspect Ratios ────────────────────────────────
  static const double aspectRatioPoster     = 2 / 3;   // portrait card
  static const double aspectRatioBackdrop   = 16 / 9;  // landscape / hero
  static const double aspectRatioSquare     = 1 / 1;
  static const double aspectRatioProfile    = 1 / 1;

  // ── Maturity ratings ─────────────────────────────────────
  static const List<String> maturityRatings = [
    'G', 'PG', 'PG-13', 'R', 'NC-17',
    'TV-Y', 'TV-Y7', 'TV-G', 'TV-PG', 'TV-14', 'TV-MA',
  ];

  // ── Default language ─────────────────────────────────────
  static const String defaultLanguage   = 'en';
  static const String defaultCountry    = 'IN';

  // ── Cache ────────────────────────────────────────────────
  static const int    imageCacheMaxAge  = 7;  // days
  static const int    apiCacheMaxAge    = 1;  // days
  static const int    maxImageCacheMB   = 200;
}