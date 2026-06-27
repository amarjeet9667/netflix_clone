import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    if (AppConfig.isTest) {
      // In test mode, we call dummyjson auth login endpoint
      // path is /auth/login
      final response = await apiClient.post('/auth/login', data: {
        'username': 'emilys',
        'password': 'emilyspass',
      });
      return UserModel.fromJson(response);
    } else {
      // Dev / Prod mock fallback
      await Future.delayed(const Duration(milliseconds: 500));
      if (email == 'emily.johnson@x.dummyjson.com' || email == 'emily@netflix.com' || email.contains('@')) {
        return UserModel.fromJson(DummyUsers.loggedInUser);
      }
      throw Exception('Invalid credentials');
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final mockUser = Map<String, dynamic>.from(DummyUsers.loggedInUser)
      ..['email'] = email
      ..['username'] = email.split('@').first;
    return UserModel.fromJson(mockUser);
  }
}
