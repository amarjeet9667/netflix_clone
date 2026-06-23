// ============================================================
//  retry_interceptor.dart
//  lib/core/networks/interceptors/retry_interceptor.dart
//
//  Auto-retries failed requests up to AppConfig.maxRetryAttempts
//  Only retries network/timeout errors — never 4xx errors
//  Uses exponential back-off: 1s → 2s → 4s
// ============================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../config/app_config.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;

  RetryInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final attempt = _getAttempt(err.requestOptions);

    final shouldRetry = _isRetryable(err) &&
                        attempt < AppConfig.maxRetryAttempts;

    if (!shouldRetry) {
      return handler.next(err);
    }

    debugPrint(
      '🔄 RetryInterceptor: attempt $attempt/${AppConfig.maxRetryAttempts} '
      '— ${err.requestOptions.uri}',
    );

    // Exponential back-off
    await Future.delayed(Duration(seconds: _backoffSeconds(attempt)));

    try {
      final options = err.requestOptions;
      _setAttempt(options, attempt + 1);
      final response = await _dio.fetch(options);
      return handler.resolve(response);
    } on DioException catch (retryErr) {
      return handler.next(retryErr);
    }
  }

  // ── Helpers ──────────────────────────────────────────────
  bool _isRetryable(DioException err) {
    return err.type == DioExceptionType.connectionTimeout  ||
           err.type == DioExceptionType.receiveTimeout     ||
           err.type == DioExceptionType.sendTimeout        ||
           err.type == DioExceptionType.connectionError    ||
           (err.type == DioExceptionType.badResponse &&
            (err.response?.statusCode ?? 0) >= 500);
  }

  int _getAttempt(RequestOptions options) =>
      (options.extra['retryAttempt'] as int?) ?? 0;

  void _setAttempt(RequestOptions options, int attempt) =>
      options.extra['retryAttempt'] = attempt;

  int _backoffSeconds(int attempt) => 1 << attempt; // 1, 2, 4
}