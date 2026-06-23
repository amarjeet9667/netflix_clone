// ============================================================
//  failure.dart
//  lib/core/errors/failure.dart
//
//  Domain-layer error types — pure Dart, no Flutter/Dio imports
//  Returned via Either<Failure, T> from repositories
//  UI maps these to user-friendly messages via AppStrings
// ============================================================

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int?   statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

// ── Network ──────────────────────────────────────────────────
/// Device has no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection.',
    super.statusCode,
  });
}

/// Request timed out
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Request timed out. Please try again.',
    super.statusCode,
  });
}

// ── Server ───────────────────────────────────────────────────
/// Server returned a non-2xx response
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });
}

/// 400 Bad Request
class BadRequestFailure extends Failure {
  const BadRequestFailure({
    super.message = 'Bad request. Please check your input.',
    super.statusCode = 400,
  });
}

/// 401 Unauthorized — token missing or invalid
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Session expired. Please sign in again.',
    super.statusCode = 401,
  });
}

/// 403 Forbidden
class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    super.message = 'You do not have permission to do that.',
    super.statusCode = 403,
  });
}

/// 404 Not Found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Content not found.',
    super.statusCode = 404,
  });
}

/// 409 Conflict (e.g. email already registered)
class ConflictFailure extends Failure {
  const ConflictFailure({
    required super.message,
    super.statusCode = 409,
  });
}

/// 422 Unprocessable Entity — validation errors from server
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    super.message = 'Validation failed.',
    super.statusCode = 422,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

/// 429 Too Many Requests
class RateLimitFailure extends Failure {
  const RateLimitFailure({
    super.message = 'Too many requests. Please slow down.',
    super.statusCode = 429,
  });
}

/// 5xx Server Error
class InternalServerFailure extends Failure {
  const InternalServerFailure({
    super.message = 'Server error. Please try again later.',
    super.statusCode = 500,
  });
}

// ── Local / Cache ────────────────────────────────────────────
/// Hive / SharedPreferences read/write failure
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Local storage error.',
    super.statusCode,
  });
}

/// Expected local data was empty / not found
class CacheEmptyFailure extends Failure {
  const CacheEmptyFailure({
    super.message = 'No cached data available.',
    super.statusCode,
  });
}

// ── Auth ─────────────────────────────────────────────────────
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.statusCode,
  });
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure({
    super.message = 'Incorrect email or password.',
    super.statusCode = 401,
  });
}

// ── Misc ─────────────────────────────────────────────────────
/// Catch-all for unhandled exceptions
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'Something went wrong. Please try again.',
    super.statusCode,
  });
}

/// Content parse / serialization error
class ParseFailure extends Failure {
  const ParseFailure({
    super.message = 'Failed to process server response.',
    super.statusCode,
  });
}
