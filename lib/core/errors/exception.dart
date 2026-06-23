// ============================================================
//  exception.dart
//  lib/core/errors/exception.dart
//
//  Data-layer exceptions — thrown by datasources, caught by
//  repository impls and converted into Failure objects.
//  Never let these leak past the repository layer.
// ============================================================

// ── Network Exceptions ───────────────────────────────────────
class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No internet connection.']);
  @override String toString() => 'NetworkException: $message';
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException([this.message = 'Request timed out.']);
  @override String toString() => 'TimeoutException: $message';
}

// ── Server Exceptions ────────────────────────────────────────
class ServerException implements Exception {
  final String  message;
  final int?    statusCode;
  const ServerException({
    this.message    = 'Server error.',
    this.statusCode,
  });
  @override String toString() => 'ServerException($statusCode): $message';
}

class BadRequestException implements Exception {
  final String message;
  const BadRequestException([this.message = 'Bad request.']);
  @override String toString() => 'BadRequestException: $message';
}

class UnauthorizedException implements Exception {
  final String message;
  const UnauthorizedException([this.message = 'Unauthorized.']);
  @override String toString() => 'UnauthorizedException: $message';
}

class ForbiddenException implements Exception {
  final String message;
  const ForbiddenException([this.message = 'Forbidden.']);
  @override String toString() => 'ForbiddenException: $message';
}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException([this.message = 'Not found.']);
  @override String toString() => 'NotFoundException: $message';
}

class ConflictException implements Exception {
  final String message;
  const ConflictException([this.message = 'Conflict.']);
  @override String toString() => 'ConflictException: $message';
}

class ValidationException implements Exception {
  final String                      message;
  final Map<String, List<String>>?  fieldErrors;
  const ValidationException({
    this.message     = 'Validation failed.',
    this.fieldErrors,
  });
  @override String toString() => 'ValidationException: $message';
}

class RateLimitException implements Exception {
  final String message;
  const RateLimitException([this.message = 'Too many requests.']);
  @override String toString() => 'RateLimitException: $message';
}

class InternalServerException implements Exception {
  final String message;
  const InternalServerException([this.message = 'Internal server error.']);
  @override String toString() => 'InternalServerException: $message';
}

// ── Local / Cache Exceptions ─────────────────────────────────
class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error.']);
  @override String toString() => 'CacheException: $message';
}

class CacheEmptyException implements Exception {
  final String message;
  const CacheEmptyException([this.message = 'No cached data.']);
  @override String toString() => 'CacheEmptyException: $message';
}

// ── Auth Exceptions ──────────────────────────────────────────
class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Authentication error.']);
  @override String toString() => 'AuthException: $message';
}

class InvalidCredentialsException implements Exception {
  final String message;
  const InvalidCredentialsException([this.message = 'Invalid credentials.']);
  @override String toString() => 'InvalidCredentialsException: $message';
}

class TokenExpiredException implements Exception {
  final String message;
  const TokenExpiredException([this.message = 'Token expired.']);
  @override String toString() => 'TokenExpiredException: $message';
}

// ── Parse Exceptions ─────────────────────────────────────────
class ParseException implements Exception {
  final String message;
  const ParseException([this.message = 'Failed to parse response.']);
  @override String toString() => 'ParseException: $message';
}

// ── Misc ─────────────────────────────────────────────────────
class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException([this.message = 'Unexpected error.']);
  @override String toString() => 'UnexpectedException: $message';
}
