// lib/features/user/data/datasources/user_remote_datasource.dart
import 'package:netflix_clone/core/config/app_config.dart';
import 'package:netflix_clone/core/dummy/dummy_data.dart';
import 'package:netflix_clone/core/errors/exception.dart';
import 'package:netflix_clone/core/networks/api_client.dart';
import '../models/profile_model.dart';
import '../models/user_account_model.dart';
import '../models/subscription_model.dart';

abstract class UserRemoteDataSource {
  Future<UserAccountModel> getAccount();
  Future<List<ProfileModel>> getProfiles();
  Future<ProfileModel> createProfile({
    required String name,
    String? avatarUrl,
    required bool isKids,
  });
  Future<ProfileModel> updateProfile({
    required String profileId,
    required String name,
    String? avatarUrl,
    required bool isKids,
    required String maturityRating,
  });
  Future<void> deleteProfile(String profileId);
  Future<SubscriptionModel> getSubscription();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient apiClient;
  const UserRemoteDataSourceImpl(this.apiClient);

  bool get _useDummy => AppConfig.isTest || AppConfig.isDev;

  @override
  Future<UserAccountModel> getAccount() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return UserAccountModel.fromDummyMap(DummyUsers.loggedInUser);
    }
    try {
      final response = await apiClient.get('/auth/me');
      return UserAccountModel.fromJson(response as Map<String, dynamic>);
    } on Exception {
      throw ServerException(message: 'Failed to load account.');
    }
  }

  @override
  Future<List<ProfileModel>> getProfiles() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return DummyUsers.profiles.map(ProfileModel.fromDummyMap).toList();
    }
    try {
      final response = await apiClient.get('/users/profiles');
      return (response as List)
          .map((e) => ProfileModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw ServerException(message: 'Failed to load profiles.');
    }
  }

  @override
  Future<ProfileModel> createProfile({
    required String name,
    String? avatarUrl,
    required bool isKids,
  }) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 300));
      return ProfileModel(
        id: 'p_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        avatarUrl: avatarUrl ?? 'https://dummyjson.com/icon/emilys/128',
        isKids: isKids,
        maturityRating: isKids ? 'G' : 'All Maturity Ratings',
        language: 'en',
      );
    }
    try {
      final response = await apiClient.post(
        '/users/profiles/create',
        data: {'name': name, 'avatarUrl': avatarUrl, 'isKids': isKids},
      );
      return ProfileModel.fromJson(response as Map<String, dynamic>);
    } on Exception {
      throw ServerException(message: 'Failed to create profile.');
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String profileId,
    required String name,
    String? avatarUrl,
    required bool isKids,
    required String maturityRating,
  }) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 300));
      return ProfileModel(
        id: profileId,
        name: name,
        avatarUrl: avatarUrl ?? 'https://dummyjson.com/icon/emilys/128',
        isKids: isKids,
        maturityRating: maturityRating,
        language: 'en',
      );
    }
    try {
      final response = await apiClient.put(
        '/users/profiles/update',
        data: {
          'profileId': profileId,
          'name': name,
          'avatarUrl': avatarUrl,
          'isKids': isKids,
          'maturityRating': maturityRating,
        },
      );
      return ProfileModel.fromJson(response as Map<String, dynamic>);
    } on Exception {
      throw ServerException(message: 'Failed to update profile.');
    }
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return;
    }
    try {
      await apiClient.delete('/users/profiles/$profileId');
    } on Exception {
      throw ServerException(message: 'Failed to delete profile.');
    }
  }

  @override
  Future<SubscriptionModel> getSubscription() async {
    if (_useDummy) {
      await Future.delayed(const Duration(milliseconds: 200));
      return SubscriptionModel.dummy();
    }
    try {
      final response = await apiClient.get('/users/subscription');
      return SubscriptionModel.fromJson(response as Map<String, dynamic>);
    } on Exception {
      throw ServerException(message: 'Failed to load subscription.');
    }
  }
}
