// lib/features/user/data/datasources/user_local_datasource.dart
import 'package:netflix_clone/core/errors/exception.dart';

abstract class UserLocalDataSource {
  Future<String?> getActiveProfileId();
  Future<void> saveActiveProfileId(String profileId);
  Future<void> clearActiveProfileId();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  // In-memory — swap with SharedPreferences:
  // prefs.getString(AppConstants.kActiveProfileId)
  String? _activeProfileId;

  @override
  Future<String?> getActiveProfileId() async {
    return _activeProfileId;
  }

  @override
  Future<void> saveActiveProfileId(String profileId) async {
    try {
      _activeProfileId = profileId;
      // Real: await prefs.setString(AppConstants.kActiveProfileId, profileId);
    } catch (e) {
      throw CacheException('Failed to save active profile: $e');
    }
  }

  @override
  Future<void> clearActiveProfileId() async {
    try {
      _activeProfileId = null;
      // Real: await prefs.remove(AppConstants.kActiveProfileId);
    } catch (e) {
      throw CacheException('Failed to clear active profile: $e');
    }
  }
}
