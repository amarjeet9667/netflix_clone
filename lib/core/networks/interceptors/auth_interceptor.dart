// ============================================================
//  auth_interceptor.dart
//  lib/core/networks/interceptors/auth_interceptor.dart
//
//  Attaches Bearer token to every request
//  Handles 401 → token refresh → retry original request
//  On refresh failure → clears storage and forces re-login
// ============================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/app_constants.dart';

class AuthInterceptor extends Interceptor {
  // Lazy Dio instance for refresh call (avoids circular dep)
  Dio? _refreshDio;

  @override
  void onRequest(
    RequestOptions         options,
    RequestInterceptorHandler handler,
  ) {
    final token = _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException          err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only handle 401 and only if we have a refresh token
    if (err.response?.statusCode == 401) {
      final refreshToken = _getRefreshToken();

      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          final newToken = await _refreshAccessToken(
            refreshToken: refreshToken,
            failedRequest: err.requestOptions,
          );

          if (newToken != null) {
            // Retry original request with new token
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newToken';

            final clonedRequest = await _refreshDio!.fetch(opts);
            return handler.resolve(clonedRequest);
          }
        } catch (_) {
          // Refresh failed — clear auth and force re-login
          _clearAuthData();
        }
      }

      _clearAuthData();
    }

    handler.next(err);
  }

  // ── Private helpers ──────────────────────────────────────
  String? _getToken() {
    // TODO: replace with your StorageService / Hive read
    // return sl<StorageService>().getString(AppConstants.kAuthToken);
    return null;
  }

  String? _getRefreshToken() {
    // TODO: return sl<StorageService>().getString(AppConstants.kRefreshToken);
    return null;
  }

  void _clearAuthData() {
    // TODO: sl<StorageService>().remove(AppConstants.kAuthToken);
    // TODO: sl<StorageService>().remove(AppConstants.kRefreshToken);
    // TODO: navigate to login via AppRouter
    debugPrint('⚠️  AuthInterceptor: cleared auth — redirecting to login');
  }

  Future<String?> _refreshAccessToken({
    required String         refreshToken,
    required RequestOptions failedRequest,
  }) async {
    _refreshDio ??= Dio(
      BaseOptions(baseUrl: failedRequest.baseUrl),
    );

    final response = await _refreshDio!.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    final newToken = response.data?['token'] as String?;
    if (newToken != null) {
      // TODO: sl<StorageService>().setString(AppConstants.kAuthToken, newToken);
      debugPrint('✅ AuthInterceptor: token refreshed');
    }
    return newToken;
  }
}
