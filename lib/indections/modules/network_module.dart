// ============================================================
//  network_module.dart
//  lib/injection/modules/network_module.dart
//
//  Registers Dio + interceptors + ApiClient
// ============================================================

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/networks/interceptors/auth_interceptor.dart';
import 'package:netflix_clone/core/networks/interceptors/logging_interceptor.dart';

class NetworkModule {
  NetworkModule._();

  static void register(GetIt sl) {
    // ── Interceptors (register first — Dio depends on them) ──
    sl.registerLazySingleton<LoggingInterceptor>(
      () => LoggingInterceptor(),
    );

    sl.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(),
    );

    // ── Dio instance ─────────────────────────────────────────
    sl.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl:        AppConfig.apiBaseUrl,
          connectTimeout: AppConfig.connectTimeout,
          receiveTimeout: AppConfig.receiveTimeout,
          sendTimeout:    AppConfig.sendTimeout,
          headers: const {
            'Content-Type': 'application/json',
            'Accept':       'application/json',
          },
        ),
      );

      dio.interceptors.add(sl<AuthInterceptor>());
      if (AppConfig.enableLogging) {
        dio.interceptors.add(sl<LoggingInterceptor>());
      }

      return dio;
    });

    // ── Api Client (thin wrapper around Dio) ─────────────────
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(sl<Dio>()),
    );
  }
}
