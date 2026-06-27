import 'dart:convert';
import 'package:netflix_clone/core/constants/app_constants.dart';
import 'package:netflix_clone/core/services/storage_service.dart';
import 'package:netflix_clone/injections/injection_container.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storageService;
  AuthLocalDataSourceImpl({StorageService? storageService})
      : storageService = storageService ?? sl<StorageService>();

  @override
  Future<void> saveToken(String token) async {
    await storageService.setString(AppConstants.kAuthToken, token);
  }

  @override
  Future<String?> getToken() async {
    return storageService.getString(AppConstants.kAuthToken);
  }

  @override
  Future<void> deleteToken() async {
    await storageService.remove(AppConstants.kAuthToken);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final rawJson = jsonEncode(user.toJson());
    await storageService.setString('cached_user_model', rawJson);
  }

  @override
  Future<UserModel?> getUser() async {
    final rawJson = storageService.getString('cached_user_model');
    if (rawJson != null) {
      final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
      return UserModel.fromJson(decoded);
    }
    return null;
  }

  @override
  Future<void> deleteUser() async {
    await storageService.remove('cached_user_model');
  }
}
