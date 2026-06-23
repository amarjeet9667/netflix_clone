// ============================================================
//  logging_interceptor.dart
//  lib/core/networks/interceptors/logging_interceptor.dart
//
//  Pretty-prints every request and response to the console
//  Only active when AppConfig.enableLogging == true (dev/test)
//  Never runs in prod
// ============================================================

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n${'─' * 60}');
    debugPrint('📤 REQUEST  [${options.method}]  ${options.uri}');
    if (options.headers.isNotEmpty) {
      debugPrint('   Headers : ${_sanitizeHeaders(options.headers)}');
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint('   Params  : ${options.queryParameters}');
    }
    if (options.data != null) {
      debugPrint('   Body    : ${_truncate(options.data.toString())}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n${'─' * 60}');
    debugPrint(
      '📥 RESPONSE [${response.statusCode}]  '
      '${response.requestOptions.uri}',
    );
    debugPrint('   Data    : ${_truncate(response.data.toString())}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n${'─' * 60}');
    debugPrint(
      '❌ ERROR    [${err.response?.statusCode ?? 'NO CODE'}]  '
      '${err.requestOptions.uri}',
    );
    debugPrint('   Type    : ${err.type}');
    debugPrint('   Message : ${err.message}');
    if (err.response?.data != null) {
      debugPrint('   Body    : ${_truncate(err.response!.data.toString())}');
    }
    handler.next(err);
  }

  // ── Helpers ──────────────────────────────────────────────
  /// Masks Authorization header so token doesn't appear in logs
  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    final sanitized = Map<String, dynamic>.from(headers);
    if (sanitized.containsKey('Authorization')) {
      sanitized['Authorization'] = 'Bearer [REDACTED]';
    }
    return sanitized;
  }

  /// Truncates long bodies so the log stays readable
  String _truncate(String text, {int maxLength = 500}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}… [truncated]';
  }
}
