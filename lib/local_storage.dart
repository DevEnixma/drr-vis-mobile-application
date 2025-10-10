import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'utils/constants/key_localstorage.dart';

abstract class LocalStorageC {
  Future<void> setValueString(String key, String value);
  Future<void> setValueDouble(String key, double value);
  Future<void> setValueBool(String key, bool value);
  Future<String?> getValueString(String key);
  Future<double?> getValueDouble(String key);
  Future<bool?> getValueBool(String key);
  Future<void> removeValueStorage(String key);
  Future<void> removeStorageLogout();
}

class LocalStorage extends LocalStorageC {
  @override
  Future<void> setValueString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<void> setValueDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  @override
  Future<void> setValueBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Future<String?> getValueString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<double?> getValueDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  @override
  Future<bool> getValueBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<void> removeValueStorage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<void> removeStorageLogout() async {
    logger.i('=======[clear logout]=====');
    await removeValueStorage(KeyLocalStorage.accessToken);
    await removeValueStorage(KeyLocalStorage.refreshToken);
    await removeValueStorage(KeyLocalStorage.username);
    await removeValueStorage(KeyLocalStorage.password);
    await removeValueStorage(KeyLocalStorage.isUser);
    await removeValueStorage(KeyLocalStorage.weightUnitId);
  }
}
