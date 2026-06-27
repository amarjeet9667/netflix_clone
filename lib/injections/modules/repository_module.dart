// ============================================================
//  repository_module.dart
//  lib/injection/modules/repository_module.dart
//
//  Binds abstract repository interfaces → concrete impls
//  domain/repositories (abstract) ← data/repositories (impl)
// ============================================================

import 'package:get_it/get_it.dart';

// ── Auth ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:netflix_clone/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:netflix_clone/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:netflix_clone/features/auth/domain/repositories/auth_repository.dart';

// ── Home ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/home/data/datasources/home_remote_datasource.dart';
import 'package:netflix_clone/features/home/data/repositories/home_repository_impl.dart';
import 'package:netflix_clone/features/home/domain/repositories/home_repository.dart';

// ── Movies ───────────────────────────────────────────────────
import 'package:netflix_clone/features/movies/data/datasources/movie_local_datasource.dart';
import 'package:netflix_clone/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:netflix_clone/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:netflix_clone/features/movies/domain/repositories/movie_repository.dart';

// ── TV Shows ─────────────────────────────────────────────────
import 'package:netflix_clone/features/tv_shows/data/datasources/tvshow_remote_datasource.dart';
import 'package:netflix_clone/features/tv_shows/data/repositories/tvshow_repository_impl.dart';
import 'package:netflix_clone/features/tv_shows/domain/repositories/tvshow_repository.dart';

// ── Search ───────────────────────────────────────────────────
import 'package:netflix_clone/features/search/data/datasources/search_remote_datasource.dart';
import 'package:netflix_clone/features/search/data/repositories/search_repository_impl.dart';
import 'package:netflix_clone/features/search/domain/repositories/search_repository.dart';

// ── User ─────────────────────────────────────────────────────
import 'package:netflix_clone/features/user/data/datasources/user_local_datasource.dart';
import 'package:netflix_clone/features/user/data/datasources/user_remote_datasource.dart';
import 'package:netflix_clone/features/user/data/repositories/user_repository_impl.dart';
import 'package:netflix_clone/features/user/domain/repositories/user_repository.dart';

// ── Watchlist ────────────────────────────────────────────────
import 'package:netflix_clone/features/watchlist/data/datasources/watchlist_local_datasource.dart';
import 'package:netflix_clone/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:netflix_clone/features/watchlist/domain/repositories/watchlist_repository.dart';

// ── Downloads ────────────────────────────────────────────────
import 'package:netflix_clone/features/downloads/data/datasources/download_local_datasource.dart';
import 'package:netflix_clone/features/downloads/data/repositories/download_repository_impl.dart';
import 'package:netflix_clone/features/downloads/domain/repositories/download_repository.dart';

// ── Notifications ────────────────────────────────────────────
import 'package:netflix_clone/features/notifications/data/datasources/fcm_datasource.dart';
import 'package:netflix_clone/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:netflix_clone/features/notifications/domain/repositories/notification_repository.dart';

// ── Player ───────────────────────────────────────────────────
import 'package:netflix_clone/features/player/data/datasources/player_local_datasource.dart';
import 'package:netflix_clone/features/player/data/datasources/player_remote_datasource.dart';
import 'package:netflix_clone/features/player/data/repositories/player_repository_impl.dart';
import 'package:netflix_clone/features/player/domain/repositories/player_repository.dart';

// ── Core ─────────────────────────────────────────────────────
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/networks/network_info.dart';

class RepositoryModule {
  RepositoryModule._();

  static void register(GetIt sl) {
    _registerDataSources(sl);
    _registerRepositories(sl);
  }

  // ── Data Sources ───────────────────────────────────────────
  static void _registerDataSources(GetIt sl) {
    // Auth
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
    );
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );

    // Home
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl<ApiClient>()),
    );

    // Movies
    sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(sl<ApiClient>()),
    );
    sl.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(),
    );

    // TV Shows
    sl.registerLazySingleton<TVShowRemoteDataSource>(
      () => TVShowRemoteDataSourceImpl(sl<ApiClient>()),
    );

    // Search
    sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(sl<ApiClient>()),
    );

    // User
    sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(sl<ApiClient>()),
    );
    sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(),
    );

    // Watchlist
    sl.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(),
    );

    // Downloads
    sl.registerLazySingleton<DownloadLocalDataSource>(
      () => DownloadLocalDataSourceImpl(),
    );

    // Notifications
    sl.registerLazySingleton<FCMDataSource>(
      () => FCMDataSourceImpl(),
    );

    // Player
    sl.registerLazySingleton<PlayerRemoteDataSource>(
      () => PlayerRemoteDataSourceImpl(sl<ApiClient>()),
    );
    sl.registerLazySingleton<PlayerLocalDataSource>(
      () => PlayerLocalDataSourceImpl(),
    );
  }

  // ── Repositories ───────────────────────────────────────────
  static void _registerRepositories(GetIt sl) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl<AuthRemoteDataSource>(),
        localDataSource:  sl<AuthLocalDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        remoteDataSource: sl<HomeRemoteDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: sl<MovieRemoteDataSource>(),
        localDataSource:  sl<MovieLocalDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<TVShowRepository>(
      () => TVShowRepositoryImpl(
        remoteDataSource: sl<TVShowRemoteDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(
        remoteDataSource: sl<SearchRemoteDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl<UserRemoteDataSource>(),
        localDataSource:  sl<UserLocalDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );

    sl.registerLazySingleton<WatchlistRepository>(
      () => WatchlistRepositoryImpl(
        localDataSource: sl<WatchlistLocalDataSource>(),
      ),
    );

    sl.registerLazySingleton<DownloadRepository>(
      () => DownloadRepositoryImpl(
        localDataSource: sl<DownloadLocalDataSource>(),
      ),
    );

    sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(
        fcmDataSource: sl<FCMDataSource>(),
      ),
    );

    sl.registerLazySingleton<PlayerRepository>(
      () => PlayerRepositoryImpl(
        remoteDataSource: sl<PlayerRemoteDataSource>(),
        localDataSource:  sl<PlayerLocalDataSource>(),
        networkInfo:      sl<NetworkInfo>(),
      ),
    );
  }
}