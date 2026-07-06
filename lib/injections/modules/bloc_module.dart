// ============================================================
//  bloc_module.dart
//  lib/injection/modules/bloc_module.dart
//
//  Registers all BLoCs and Cubits
//  BLoCs use registerFactory (new instance per BlocProvider)
//  Cubits that are global use registerLazySingleton
// ============================================================

import 'package:get_it/get_it.dart';

// ── Feature BLoCs ────────────────────────────────────────────
import 'package:netflix_clone/features/auth/domain/usecases/login_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/register_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/logout_usecase.dart';
import 'package:netflix_clone/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:netflix_clone/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:netflix_clone/features/home/domain/usecases/get_featured_banners_usecase.dart';
import 'package:netflix_clone/features/home/domain/usecases/get_home_sections_usecase.dart';
import 'package:netflix_clone/features/home/presentation/bloc/home_bloc.dart';

import 'package:netflix_clone/features/movies/domain/usecases/get_trending_movies_usecase.dart';
import 'package:netflix_clone/features/movies/domain/usecases/get_movie_detail_usecase.dart';
import 'package:netflix_clone/features/movies/domain/usecases/get_similar_movies_usecase.dart';
import 'package:netflix_clone/features/movies/presentation/bloc/movies_bloc/movies_bloc.dart';

import 'package:netflix_clone/features/tv_shows/domain/usecases/get_tv_shows_usecase.dart';
import 'package:netflix_clone/features/tv_shows/domain/usecases/get_episodes_usecase.dart';
import 'package:netflix_clone/features/tv_shows/presentation/bloc/tvshow_bloc.dart';

import 'package:netflix_clone/features/search/domain/usecases/search_content_usecase.dart';
import 'package:netflix_clone/features/search/domain/usecases/get_genre_list_usecase.dart';
import 'package:netflix_clone/features/search/presentation/bloc/search_bloc.dart';

import 'package:netflix_clone/features/user/domain/usecases/get_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/update_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/switch_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/create_profile_usecase.dart';
import 'package:netflix_clone/features/user/domain/usecases/delete_profile_usecase.dart';
import 'package:netflix_clone/features/user/presentation/bloc/profile_bloc.dart';

import 'package:netflix_clone/features/watchlist/domain/usecases/toggle_watchlist_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_my_list_usecase.dart';
import 'package:netflix_clone/features/watchlist/domain/usecases/get_continue_watching_usecase.dart';
import 'package:netflix_clone/features/watchlist/presentation/bloc/watchlist_bloc.dart';

import 'package:netflix_clone/features/downloads/domain/usecases/start_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/cancel_download_usecase.dart';
import 'package:netflix_clone/features/downloads/domain/usecases/get_downloads_usecase.dart';
import 'package:netflix_clone/features/downloads/presentation/bloc/download_bloc.dart';

import 'package:netflix_clone/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:netflix_clone/features/notifications/presentation/bloc/notification_bloc.dart';

import 'package:netflix_clone/features/player/domain/usecases/get_stream_url_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/save_watch_progress_usecase.dart';
import 'package:netflix_clone/features/player/domain/usecases/get_subtitles_usecase.dart';
import 'package:netflix_clone/features/player/presentation/bloc/player_bloc.dart';

// ── Shared Cubits ────────────────────────────────────────────
import 'package:netflix_clone/shared/cubit/bottom_nav_cubit.dart';
import 'package:netflix_clone/shared/cubit/theme_cubit.dart';
import 'package:netflix_clone/shared/cubit/language_cubit.dart';


class BlocModule {
  BlocModule._();

  static void register(GetIt sl) {
    // ── registerFactory = new instance every time BlocProvider
    //    creates one. Prevents stale state across routes.
    // ── registerLazySingleton = shared global cubits only.

    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        loginUseCase:          sl<LoginUseCase>(),
        registerUseCase:       sl<RegisterUseCase>(),
        logoutUseCase:         sl<LogoutUseCase>(),
        getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      ),
    );

    sl.registerFactory<HomeBloc>(
      () => HomeBloc(
        getFeaturedBanners: sl<GetFeaturedBannersUseCase>(),
        getHomeSections:    sl<GetHomeSectionsUseCase>(),
      ),
    );

    sl.registerFactory<MoviesBloc>(
      () => MoviesBloc(
        getTrendingMovies: sl<GetTrendingMoviesUseCase>(),
        getMovieDetail:    sl<GetMovieDetailUseCase>(),
        getSimilarMovies:  sl<GetSimilarMoviesUseCase>(),
      ),
    );

    sl.registerFactory<TVShowBloc>(
      () => TVShowBloc(
        getTVShows:   sl<GetTVShowsUseCase>(),
        getEpisodes:  sl<GetEpisodesUseCase>(),
      ),
    );

    sl.registerFactory<SearchBloc>(
      () => SearchBloc(
        searchContent:  sl<SearchContentUseCase>(),
        getGenreList:   sl<GetGenreListUseCase>(),
      ),
    );

    sl.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        getProfile:     sl<GetProfileUseCase>(),
        updateProfile:  sl<UpdateProfileUseCase>(),
        switchProfile:  sl<SwitchProfileUseCase>(),
        createProfile:  sl<CreateProfileUseCase>(),
        deleteProfile:  sl<DeleteProfileUseCase>(),
      ),
    );

    sl.registerFactory<WatchlistBloc>(
      () => WatchlistBloc(
        toggleWatchlist:      sl<ToggleWatchlistUseCase>(),
        getMyList:            sl<GetMyListUseCase>(),
        getContinueWatching:  sl<GetContinueWatchingUseCase>(),
      ),
    );

    sl.registerFactory<DownloadBloc>(
      () => DownloadBloc(
        startDownload:  sl<StartDownloadUseCase>(),
        cancelDownload: sl<CancelDownloadUseCase>(),
        getDownloads:   sl<GetDownloadsUseCase>(),
      ),
    );

    sl.registerFactory<NotificationBloc>(
      () => NotificationBloc(
        getNotifications: sl<GetNotificationsUseCase>(),
      ),
    );

    sl.registerFactory<PlayerBloc>(
      () => PlayerBloc(
        getStreamUrl:      sl<GetStreamUrlUseCase>(),
        saveWatchProgress: sl<SaveWatchProgressUseCase>(),
        getSubtitles:      sl<GetSubtitlesUseCase>(),
      ),
    );

    // ── Global Cubits (singletons — persist across routes) ───
    sl.registerLazySingleton<BottomNavCubit>(() => BottomNavCubit());
    sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
    sl.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  }
}