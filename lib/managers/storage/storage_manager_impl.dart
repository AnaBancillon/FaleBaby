import 'dart:collection';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_manager.dart';

class StorageManagerImpl implements StorageManager {
  final FlutterSecureStorage _storage;

  StorageManagerImpl({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<dynamic> read(key, {defaultValue}) async {
    final valueJson = await _storage.read(key: key);
    if (valueJson == null) return defaultValue;
    Map<String, dynamic> json = jsonDecode(valueJson);
    dynamic value = json[key];
    return value ?? defaultValue;
  }

  @override
  Future<void> delete(String key) async {
    var valueJson = await _storage.read(key: key);
    if (valueJson != null) await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<void> write(String key, dynamic value) async {
    var map = HashMap<String, dynamic>();
    map[key] = value;
    var valueStr = jsonEncode(map);
    await _storage.write(key: key, value: valueStr);
  }

  @override
  Future<bool> contains(String key) async {
    var result = await _storage.read(key: key);
    return result != null;
  }
}
