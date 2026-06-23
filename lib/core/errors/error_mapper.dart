// ============================================================
//  error_mapper.dart
//  lib/core/errors/error_mapper.dart
//
//  Converts exceptions → Failures (used inside repo impls)
//  Converts Dio errors → app exceptions (used in datasources)
//  Single place — change mapping once, applies everywhere
// ============================================================

import 'package:dio/dio.dart';

import 'exception.dart';
import 'failure.dart';

class ErrorMapper {
  ErrorMapper._();

  // ── Dio Error → App Exception ─────────────────────────────
  // Call this in datasources inside the DioException catch block
  static Exception fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return _fromStatusCode(
          statusCode: e.response?.statusCode,
          message: _extractMessage(e.response),
          data: e.response?.data,
        );

      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled.');

      case DioExceptionType.unknown:
      default:
        if (e.error?.toString().contains('SocketException') == true) {
          return const NetworkException();
        }
        return UnexpectedException(e.message ?? 'Unknown error.');
    }
  }

  // ── Status Code → Exception ───────────────────────────────
  static Exception _fromStatusCode({
    int? statusCode,
    String? message,
    dynamic data,
  }) {
    switch (statusCode) {
      case 400:
        return BadRequestException(message ?? 'Bad request.');
      case 401:
        return UnauthorizedException(message ?? 'Unauthorized.');
      case 403:
        return ForbiddenException(message ?? 'Forbidden.');
      case 404:
        return NotFoundException(message ?? 'Not found.');
      case 409:
        return ConflictException(message ?? 'Conflict.');
      case 422:
        return ValidationException(
          message: message ?? 'Validation failed.',
          fieldErrors: _extractFieldErrors(data),
        );
      case 429:
        return const RateLimitException();
      case 500:
      case 502:
      case 503:
        return InternalServerException(message ?? 'Server error.');
      default:
        return ServerException(
          message: message ?? 'Unexpected server error.',
          statusCode: statusCode,
        );
    }
  }

  // ── Exception → Failure ───────────────────────────────────
  // Call this in repository impls inside the catch block
  static Failure fromException(Exception e) {
    if (e is NetworkException) return NetworkFailure(message: e.message);
    if (e is TimeoutException) return TimeoutFailure(message: e.message);
    if (e is UnauthorizedException)
      return UnauthorizedFailure(message: e.message);
    if (e is ForbiddenException) return ForbiddenFailure(message: e.message);
    if (e is NotFoundException) return NotFoundFailure(message: e.message);
    if (e is BadRequestException) return BadRequestFailure(message: e.message);
    if (e is ConflictException) return ConflictFailure(message: e.message);
    if (e is ValidationException)
      return ValidationFailure(message: e.message, fieldErrors: e.fieldErrors);
    if (e is RateLimitException) return const RateLimitFailure();
    if (e is InternalServerException)
      return InternalServerFailure(message: e.message);
    if (e is ServerException)
      return ServerFailure(message: e.message, statusCode: e.statusCode);
    if (e is InvalidCredentialsException)
      return InvalidCredentialsFailure(message: e.message);
    if (e is TokenExpiredException) return const UnauthorizedFailure();
    if (e is AuthException) return AuthFailure(message: e.message);
    if (e is CacheEmptyException) return CacheEmptyFailure(message: e.message);
    if (e is CacheException) return CacheFailure(message: e.message);
    if (e is ParseException) return ParseFailure(message: e.message);

    return const UnexpectedFailure();
  }

  // ── Dio Error → Failure (shortcut for repos using Dio directly) ──
  static Failure fromDioFailure(DioException e) =>
      fromException(fromDioError(e));

  // ── Helpers ──────────────────────────────────────────────
  static String? _extractMessage(Response? response) {
    try {
      final data = response?.data;
      if (data is Map) {
        return data['message']?.toString() ??
            data['error']?.toString() ??
            data['msg']?.toString();
      }
    } catch (_) {}
    return null;
  }

  static Map<String, List<String>>? _extractFieldErrors(dynamic data) {
    try {
      if (data is Map && data.containsKey('errors')) {
        final errors = data['errors'] as Map;
        return errors.map(
          (k, v) => MapEntry(
            k.toString(),
            (v as List).map((e) => e.toString()).toList(),
          ),
        );
      }
    } catch (_) {}
    return null;
  }
}
