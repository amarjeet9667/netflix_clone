// ============================================================
//  AppStrings — All user-facing text in one place
//  Makes i18n / localization easy — just swap this file
// ============================================================

class AppStrings {
  AppStrings._();

  // ── App ──────────────────────────────────────────────────
  static const String appName          = 'Netflix';

  // ── Auth ─────────────────────────────────────────────────
  static const String signIn           = 'Sign In';
  static const String signUp           = 'Sign Up';
  static const String signOut          = 'Sign Out';
  static const String emailHint        = 'Email';
  static const String passwordHint     = 'Password';
  static const String confirmPassword  = 'Confirm Password';
  static const String forgotPassword   = 'Forgot Password?';
  static const String rememberMe       = 'Remember me';
  static const String orContinueWith   = 'OR';
  static const String dontHaveAccount  = 'New to Netflix? ';
  static const String alreadyAccount   = 'Already have an account? ';
  static const String getStarted       = 'GET STARTED';
  static const String loginFailed      = 'Login failed. Please try again.';
  static const String invalidEmail     = 'Please enter a valid email.';
  static const String invalidPassword  = 'Password must be at least 6 characters.';
  static const String passwordMismatch = 'Passwords do not match.';

  // ── Navigation ───────────────────────────────────────────
  static const String navHome          = 'Home';
  static const String navSearch        = 'Search';
  static const String navDownloads     = 'Downloads';
  static const String navMore          = 'More';
  static const String navTvShows       = 'TV Shows';
  static const String navMovies        = 'Movies';
  static const String navMyList        = 'My List';

  // ── Home ─────────────────────────────────────────────────
  static const String trendingNow      = 'Trending Now';
  static const String continueWatching = 'Continue Watching for';
  static const String topTenInIndia    = 'Top 10 in India Today';
  static const String netflixOriginals = 'Netflix Originals';
  static const String newReleases      = 'New Releases';
  static const String myList           = 'My List';
  static const String popularOnNetflix = 'Popular on Netflix';

  // ── Buttons ──────────────────────────────────────────────
  static const String btnPlay          = 'Play';
  static const String btnMoreInfo      = 'More Info';
  static const String btnAddToList     = '+ My List';
  static const String btnRemoveList    = '✓ My List';
  static const String btnDownload      = 'Download';
  static const String btnShare         = 'Share';
  static const String btnRate          = 'Rate';
  static const String btnResume        = 'Resume';
  static const String btnSeeAll        = 'See All';
  static const String btnRetry         = 'Try Again';

  // ── Detail Page ──────────────────────────────────────────
  static const String cast             = 'Cast';
  static const String director         = 'Director';
  static const String moreLikeThis     = 'More Like This';
  static const String episodes         = 'Episodes';
  static const String trailers         = 'Trailers & More';
  static const String netflixOriginal  = 'N SERIES';
  static const String match            = 'Match';
  static const String season           = 'Season';
  static const String episode          = 'Episode';

  // ── Search ───────────────────────────────────────────────
  static const String searchHint       = 'Search for a show, movie, genre...';
  static const String searchTitle      = 'Search';
  static const String topSearches      = 'Top Searches';
  static const String noResults        = 'No results found for';
  static const String browseByGenre    = 'Browse by Genre';

  // ── Downloads ────────────────────────────────────────────
  static const String downloadsTitle   = 'Downloads';
  static const String downloadSmart    = 'Smart Downloads';
  static const String downloadFind     = 'Find Something to Download';
  static const String downloadFindSub  = 'Shows and movies you download appear here.';
  static const String downloading      = 'Downloading...';
  static const String downloaded       = 'Downloaded';
  static const String downloadCancel   = 'Cancel Download';
  static const String downloadDelete   = 'Delete Download';
  static const String downloadExpires  = 'Expires';

  // ── Player ───────────────────────────────────────────────
  static const String playerEpisode    = 'Next Episode';
  static const String playerSkipIntro  = 'Skip Intro';
  static const String playerSkipRecap  = 'Skip Recap';
  static const String playerSubtitles  = 'Subtitles';
  static const String playerAudio      = 'Audio';
  static const String playerQuality    = 'Quality';
  static const String playerSpeed      = 'Playback Speed';

  // ── Notifications ────────────────────────────────────────
  static const String notificationsTitle = 'Notifications';
  static const String noNotifications    = 'No notifications yet.';
  static const String markAllRead        = 'Mark all as read';

  // ── Profile ──────────────────────────────────────────────
  static const String whoIsWatching    = 'Who\'s Watching?';
  static const String manageProfiles   = 'Manage Profiles';
  static const String addProfile       = 'Add Profile';
  static const String editProfile      = 'Edit Profile';
  static const String deleteProfile    = 'Delete Profile';
  static const String kidsProfile      = 'Kids';
  static const String profileName      = 'Profile Name';
  static const String gameHandle       = 'Game Handle';
  static const String maturitySettings = 'Maturity Settings';
  static const String profileSaved     = 'Saved';

  // ── Account ──────────────────────────────────────────────
  static const String account          = 'Account';
  static const String membership       = 'Membership & Billing';
  static const String planDetails      = 'Plan Details';
  static const String appSettings      = 'App Settings';
  static const String helpCenter       = 'Help Center';
  static const String privacyPolicy    = 'Privacy Policy';
  static const String termsOfUse       = 'Terms of Use';
  static const String cookiePrefs      = 'Cookie Preferences';

  // ── Errors ───────────────────────────────────────────────
  static const String errGeneric       = 'Something went wrong. Please try again.';
  static const String errNoInternet    = 'No internet connection.';
  static const String errTimeout       = 'Request timed out. Please try again.';
  static const String errNotFound      = 'Content not found.';
  static const String errUnauthorized  = 'Session expired. Please sign in again.';
  static const String errServer        = 'Server error. Please try again later.';

  // ── Empty States ─────────────────────────────────────────
  static const String emptyMyList      = 'Your list is empty.\nAdd shows and movies to watch later.';
  static const String emptySearch      = 'Try different keywords or browse by genre.';
  static const String emptyDownloads   = 'You have no downloads.\nFind something to download.';
}