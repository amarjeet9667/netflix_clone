// ============================================================
//  api_client.dart
//  lib/core/networks/api_client.dart
//
//  Thin wrapper around Dio that:
//  - Catches DioException and maps to app exceptions
//  - Provides typed get/post/put/patch/delete helpers
//  - All methods return the raw response data (Map/List)
//    Datasources do the model parsing
// ============================================================

import 'package:dio/dio.dart';

import '../errors/error_mapper.dart';
import '../errors/exception.dart';

class ApiClient {
  final Dio _dio;
  const ApiClient(this._dio);

  // ── GET ──────────────────────────────────────────────────
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options?              options,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options:         options,
        cancelToken:     cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  // ── POST ─────────────────────────────────────────────────
  Future<dynamic> post(
    String path, {
    dynamic               data,
    Map<String, dynamic>? queryParameters,
    Options?              options,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data:            data,
        queryParameters: queryParameters,
        options:         options,
        cancelToken:     cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  // ── PUT ──────────────────────────────────────────────────
  Future<dynamic> put(
    String path, {
    dynamic               data,
    Map<String, dynamic>? queryParameters,
    Options?              options,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data:            data,
        queryParameters: queryParameters,
        options:         options,
        cancelToken:     cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  // ── PATCH ────────────────────────────────────────────────
  Future<dynamic> patch(
    String path, {
    dynamic               data,
    Map<String, dynamic>? queryParameters,
    Options?              options,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data:            data,
        queryParameters: queryParameters,
        options:         options,
        cancelToken:     cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  // ── DELETE ───────────────────────────────────────────────
  Future<dynamic> delete(
    String path, {
    dynamic               data,
    Map<String, dynamic>? queryParameters,
    Options?              options,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data:            data,
        queryParameters: queryParameters,
        options:         options,
        cancelToken:     cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }

  // ── MULTIPART (file upload) ──────────────────────────────
  Future<dynamic> upload(
    String path, {
    required FormData     formData,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
    CancelToken?          cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data:             formData,
        queryParameters:  queryParameters,
        onSendProgress:   onSendProgress,
        cancelToken:      cancelToken,
        options: Options(contentType: 'multipart/form-data'),
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorMapper.fromDioError(e);
    } catch (e) {
      throw UnexpectedException(e.toString());
    }
  }
}