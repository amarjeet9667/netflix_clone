// ============================================================
//  usecase_module.dart
//  lib/injection/modules/usecase_module.dart
//
//  Registers every use case — depends on repositories only
// ============================================================

import 'package:get_it/get_it.dart';

// ── Auth ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/auth/domain/repositories/auth_repository.dart';
import 'package:netflix_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/register_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/logout_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/get_current_user_usecase.dart';

// ── Home ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/home/domain/repositories/home_repository.dart';
import 'package:netflix_clone/features/home/domain/usecases/get_featured_banners_usecase.dart';
import 'package:netflix_clone/features/home/domain/usecases/get_home_sections_usecase.dart';

// ── Movies ───────────────────────────────────────────────────
import 'package:netflix_clone/features/movies/domain/repositories/movie_repository.dart';
import 'package:netflix_clone/features/movies/domain/usecases/get_trending_movies_usecase.dart';
import 'package:netflix_clone/features/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:netflix_clone/features/movies/domain/usecases/get_similar_movies_usecase.dart';
import 'package:netflix_clone/features/movies/domain/usecases/search_movies_usecase.dart';

// ── TV Shows ─────────────────────────────────────────────────
import 'package:netflix_clone/features/tv_shows/domain/repositories/tvshow_repository.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_season_detail_usecase.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_episodes_usecase.dart';

// ── Search ───────────────────────────────────────────────────
import 'package:netflix_clone/features/search/domain/repositories/search_repository.dart';
import 'package:netflix_clone/features/search/domain/usecases/search_content_usecase.dart';
import 'package:netflix_clone/features/search/domain/usecases/get_genre_list_usecase.dart';

// ── User ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/user/domain/repositories/user_repository.dart';
import 'package:netflix_clone/features/user/domain/usecases/get_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/update_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/switch_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/get_subscription_usecase.dart';

// ── Watchlist ────────────────────────────────────────────────
import 'package:netflix_clone/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/toggle_watchlist_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_my_list_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_continue_watching_usecase.dart';

// ── Downloads ────────────────────────────────────────────────
import 'package:netflix_clone/features/downloads/domain/repositories/download_repository.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/start_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/cancel_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/get_downloads_usecase.dart';

// ── Notifications ────────────────────────────────────────────
import 'package:netflix_clone/features/notifications/domain/repositories/notification_repository.dart';
import 'package:netflix_clone/features/notifications/domain/usecases/get_notifications_usecase.dart';

// ── Player ───────────────────────────────────────────────────
import 'package:netflix_clone/features/player/domain/repositories/player_repository.dart';
import 'package:netflix_clone/features/player/domain/usecases/get_stream_url_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/save_watch_progress_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/get_subtitles_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/create_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/delete_profile_usecase.dart';

class UsecaseModule {
  UsecaseModule._();

  static void register(GetIt sl) {
    // ── Auth ───────────────────────────────────────────────
    sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
    sl.registerLazySingleton(() => GetCurrentUserUseCase(sl<AuthRepository>()));

    // ── Home ───────────────────────────────────────────────
    sl.registerLazySingleton(
      () => GetFeaturedBannersUseCase(sl<HomeRepository>()),
    );
    sl.registerLazySingleton(
      () => GetHomeSectionsUseCase(sl<HomeRepository>()),
    );

    // ── Movies ─────────────────────────────────────────────
    sl.registerLazySingleton(
      () => GetTrendingMoviesUseCase(sl<MovieRepository>()),
    );
    sl.registerLazySingleton(
      () => GetMovieDetailUseCase(sl<MovieRepository>()),
    );
    sl.registerLazySingleton(
      () => GetSimilarMoviesUseCase(sl<MovieRepository>()),
    );
    sl.registerLazySingleton(() => SearchMoviesUseCase(sl<MovieRepository>()));

    // ── TV Shows ───────────────────────────────────────────
    sl.registerLazySingleton(() => GetTVShowsUseCase(sl<TVShowRepository>()));
    sl.registerLazySingleton(
      () => GetSeasonDetailUseCase(sl<TVShowRepository>()),
    );
    sl.registerLazySingleton(() => GetEpisodesUseCase(sl<TVShowRepository>()));

    // ── Search ─────────────────────────────────────────────
    sl.registerLazySingleton(
      () => SearchContentUseCase(sl<SearchRepository>()),
    );
    sl.registerLazySingleton(() => GetGenreListUseCase(sl<SearchRepository>()));

    // ── User ───────────────────────────────────────────────
    sl.registerLazySingleton(() => GetProfileUseCase(sl<UserRepository>()));
    sl.registerLazySingleton(() => UpdateProfileUseCase(sl<UserRepository>()));
    sl.registerLazySingleton(() => SwitchProfileUseCase(sl<UserRepository>()));

    sl.registerLazySingleton(() => CreateProfileUseCase(sl<UserRepository>()));
    sl.registerLazySingleton(() => DeleteProfileUseCase(sl<UserRepository>()));

    sl.registerLazySingleton(
      () => GetSubscriptionUseCase(sl<UserRepository>()),
    );

    // ── Watchlist ──────────────────────────────────────────
    sl.registerLazySingleton(
      () => ToggleWatchlistUseCase(sl<WatchlistRepository>()),
    );
    sl.registerLazySingleton(() => GetMyListUseCase(sl<WatchlistRepository>()));
    sl.registerLazySingleton(
      () => GetContinueWatchingUseCase(sl<WatchlistRepository>()),
    );

    // ── Downloads ──────────────────────────────────────────
    sl.registerLazySingleton(
      () => StartDownloadUseCase(sl<DownloadRepository>()),
    );
    sl.registerLazySingleton(
      () => CancelDownloadUseCase(sl<DownloadRepository>()),
    );
    sl.registerLazySingleton(
      () => GetDownloadsUseCase(sl<DownloadRepository>()),
    );

    // ── Notifications ──────────────────────────────────────
    sl.registerLazySingleton(
      () => GetNotificationsUseCase(sl<NotificationRepository>()),
    );

    // ── Player ─────────────────────────────────────────────
    sl.registerLazySingleton(() => GetStreamUrlUseCase(sl<PlayerRepository>()));
    sl.registerLazySingleton(
      () => SaveWatchProgressUseCase(sl<PlayerRepository>()),
    );
    sl.registerLazySingleton(() => GetSubtitlesUseCase(sl<PlayerRepository>()));
  }
}
