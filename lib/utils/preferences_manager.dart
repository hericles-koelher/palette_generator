import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const String _appNamespace = "pal_gen";
  static late final SharedPreferences _preferences;
  static bool _initialized = false;

  static Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
    _initialized = true;

    if (!_preferences.containsKey(_appNamespace)) {
      _preferences.setString(_appNamespace, "");
    }
  }

  static Future<void> save(Map<String, dynamic> json) async {
    if (_initialized == false) {
      await _init();
    }

    _preferences.setString(_appNamespace, jsonEncode(json));
  }

  static Future<Object?> get([String key = _appNamespace]) async {
    if (_initialized == false) await _init();

    return _preferences.get(key);
  }
}
