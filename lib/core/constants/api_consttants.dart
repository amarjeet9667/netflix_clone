// ============================================================
//  ApiConstants — Single source of truth for all endpoints
//  Base URL lives in AppConfig.baseUrl — never hardcode here
//  Usage: ApiAuthConstants.login  →  '/auth/login'
// ============================================================

// ── Shared pagination & query keys ───────────────────────────
class ApiConstants {
  ApiConstants._();

  static const int    defaultLimit = 20;
  static const int    defaultSkip  = 0;

  static const String kLimit    = 'limit';
  static const String kSkip     = 'skip';
  static const String kQuery    = 'q';
  static const String kPage     = 'page';
  static const String kGenre    = 'genre';
  static const String kSort     = 'sort';
  static const String kOrder    = 'order';
  static const String kLanguage = 'language';
}

// ══ AUTH ══════════════════════════════════════════════════════
class ApiAuthConstants {
  ApiAuthConstants._();

  static const String _base      = '/auth';
  static const String login          = '$_base/login';
  static const String register       = '$_base/register';
  static const String logout         = '$_base/logout';
  static const String refresh        = '$_base/refresh';
  static const String forgotPassword = '$_base/forgot-password';
  static const String resetPassword  = '$_base/reset-password';
  static const String verifyOtp      = '$_base/verify-otp';
  static const String me             = '$_base/me';
}

// ══ USERS / PROFILES ══════════════════════════════════════════
class ApiUserConstants {
  ApiUserConstants._();

  static const String _base            = '/users';
  static const String base             = _base;
  static String byId(int id)           => '$_base/$id';

  static const String profiles         = '$_base/profiles';
  static String profileById(String id) => '$_base/profiles/$id';
  static const String switchProfile    = '$_base/profiles/switch';
  static const String createProfile    = '$_base/profiles/create';
  static const String deleteProfile    = '$_base/profiles/delete';
  static const String updateProfile    = '$_base/profiles/update';

  static const String subscription     = '$_base/subscription';
  static const String updateEmail      = '$_base/update-email';
  static const String updatePassword   = '$_base/update-password';
  static const String deleteAccount    = '$_base/delete-account';
}

// ══ MOVIES ════════════════════════════════════════════════════
class ApiMovieConstants {
  ApiMovieConstants._();

  static const String _base            = '/movies';
  static const String base             = _base;
  static String byId(int id)           => '$_base/$id';
  static const String trending         = '$_base/trending';
  static const String topRated         = '$_base/top-rated';
  static const String newReleases      = '$_base/new-releases';
  static const String netflixOriginals = '$_base/originals';
  static const String popular          = '$_base/popular';
  static const String search           = '$_base/search';
  static String cast(int id)           => '$_base/$id/cast';
  static String similar(int id)        => '$_base/$id/similar';
  static String trailer(int id)        => '$_base/$id/trailer';
  static String byGenre(String genre)  => '$_base/genre/$genre';

  // dummyjson.com fallback (test env)
  static const String dummyBase        = '/products';
  static String dummyById(int id)      => '/products/$id';
  static const String dummySearch      = '/products/search';
}

// ══ TV SHOWS ══════════════════════════════════════════════════
class ApiTVShowConstants {
  ApiTVShowConstants._();

  static const String _base            = '/tv';
  static const String base             = _base;
  static String byId(int id)           => '$_base/$id';
  static const String trending         = '$_base/trending';
  static const String topRated         = '$_base/top-rated';
  static const String netflixOriginals = '$_base/originals';
  static const String popular          = '$_base/popular';
  static const String search           = '$_base/search';
  static String seasons(int showId)    => '$_base/$showId/seasons';
  static String season(int showId, int n)
                                       => '$_base/$showId/seasons/$n';
  static String episodes(int showId, int n)
                                       => '$_base/$showId/seasons/$n/episodes';
  static String episode(int s, int n, int e)
                                       => '$_base/$s/seasons/$n/episodes/$e';
  static String similar(int id)        => '$_base/$id/similar';
  static String trailer(int id)        => '$_base/$id/trailer';
  static String byGenre(String genre)  => '$_base/genre/$genre';
}

// ══ HOME / BANNERS ════════════════════════════════════════════
class ApiHomeConstants {
  ApiHomeConstants._();

  static const String _base           = '/home';
  static const String sections        = '$_base/sections';
  static const String featuredBanners = '$_base/banners/featured';
  static const String heroBanner      = '$_base/banners/hero';
  static const String categories      = '$_base/categories';

  // dummyjson.com fallback
  static String dummyCategory(String name) => '/products/category/$name';
  static const String dummyCategories      = '/products/categories';
}

// ══ SEARCH ════════════════════════════════════════════════════
class ApiSearchConstants {
  ApiSearchConstants._();

  static const String _base   = '/search';
  static const String all     = _base;
  static const String movies  = '$_base/movies';
  static const String tvShows = '$_base/tv';
  static const String people  = '$_base/people';
  static const String genres  = '$_base/genres';

  // dummyjson.com fallback
  static const String dummy   = '/products/search';
}

// ══ PLAYER / STREAMING ════════════════════════════════════════
class ApiPlayerConstants {
  ApiPlayerConstants._();

  static const String _base          = '/player';
  static String streamUrl(int id)    => '$_base/$id/stream';
  static String subtitles(int id)    => '$_base/$id/subtitles';
  static String qualities(int id)    => '$_base/$id/qualities';
  static String saveProgress(int id) => '$_base/$id/progress';
  static String getProgress(int id)  => '$_base/$id/progress';
  static String skipIntro(int id)    => '$_base/$id/skip-intro';
  static String nextEpisode(int id)  => '$_base/$id/next-episode';
}

// ══ WATCHLIST / MY LIST ═══════════════════════════════════════
class ApiWatchlistConstants {
  ApiWatchlistConstants._();

  static const String _base            = '/watchlist';
  static const String base             = _base;
  static const String add              = '$_base/add';
  static const String remove           = '$_base/remove';
  static String byId(String id)        => '$_base/$id';
  static const String continueWatching = '$_base/continue-watching';
  static const String recentlyWatched  = '$_base/recently-watched';
}

// ══ DOWNLOADS ═════════════════════════════════════════════════
class ApiDownloadConstants {
  ApiDownloadConstants._();

  static const String _base              = '/downloads';
  static const String base               = _base;
  static const String start              = '$_base/start';
  static const String cancel             = '$_base/cancel';
  static const String delete             = '$_base/delete';
  static String byId(String id)          => '$_base/$id';
  static const String status             = '$_base/status';
  static const String availableQualities = '$_base/qualities';
}

// ══ NOTIFICATIONS ═════════════════════════════════════════════
class ApiNotificationConstants {
  ApiNotificationConstants._();

  static const String _base           = '/notifications';
  static const String base            = _base;
  static const String unread          = '$_base/unread';
  static String markRead(String id)   => '$_base/$id/read';
  static const String markAllRead     = '$_base/read-all';
  static const String registerToken   = '$_base/register-device';
  static const String unregisterToken = '$_base/unregister-device';
  static const String preferences     = '$_base/preferences';
}

// ══ GENRES ════════════════════════════════════════════════════
class ApiGenreConstants {
  ApiGenreConstants._();

  static const String all         = '/genres';
  static const String movieGenres = '/genres/movies';
  static const String tvGenres    = '/genres/tv';

  // dummyjson.com fallback
  static const String dummy       = '/products/categories';
}