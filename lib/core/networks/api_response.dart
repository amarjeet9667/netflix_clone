// ============================================================
//  api_response.dart
//  lib/core/networks/api_response.dart
//
//  Generic wrapper for paginated API responses
//  Datasources parse raw JSON into ApiResponse<T>
//  before handing to repositories
// ============================================================

class ApiResponse<T> {
  final T       data;
  final int?    total;
  final int?    limit;
  final int?    skip;
  final String? message;

  const ApiResponse({
    required this.data,
    this.total,
    this.limit,
    this.skip,
    this.message,
  });

  // dummyjson.com shape:
  // { "products": [...], "total": 194, "skip": 0, "limit": 20 }
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromData,
    String dataKey,
  ) {
    return ApiResponse<T>(
      data:    fromData(json[dataKey]),
      total:   json['total']   as int?,
      limit:   json['limit']   as int?,
      skip:    json['skip']    as int?,
      message: json['message'] as String?,
    );
  }

  bool get hasMore => (skip ?? 0) + (limit ?? 0) < (total ?? 0);

  int get nextSkip => (skip ?? 0) + (limit ?? 0);

  @override
  String toString() =>
      'ApiResponse(total: $total, limit: $limit, skip: $skip)';
}

// ── Single-item wrapper ───────────────────────────────────────
class ApiSingleResponse<T> {
  final T       data;
  final String? message;

  const ApiSingleResponse({required this.data, this.message});
}
