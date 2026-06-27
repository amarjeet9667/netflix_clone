import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  late final Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('netflix_clone_storage');
  }

  String? getString(String key) => _box.get(key) as String?;
  Future<void> setString(String key, String value) => _box.put(key, value);

  int? getInt(String key) => _box.get(key) as int?;
  Future<void> setInt(String key, int value) => _box.put(key, value);

  bool? getBool(String key) => _box.get(key) as bool?;
  Future<void> setBool(String key, bool value) => _box.put(key, value);

  Future<void> remove(String key) => _box.delete(key);
  Future<void> clear() => _box.clear();
}
