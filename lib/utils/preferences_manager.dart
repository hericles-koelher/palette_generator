import 'dart:convert';

import 'package:flutter/material.dart';
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

  static Future<SharedPreferences> getPreferences() async {
    final preferences = await SharedPreferences.getInstance();
    // preferences.clear();

    if (!preferences.containsKey("palette_state")) {
      Map<String, dynamic> json = {
        "palettes": [],
        "number_of_palettes": 0,
      };
      save("palette_state", json);
    }

    return preferences;
  }

  static Future<void> save(String key, dynamic value) async {
    if (_initialized == false) {
      await _init();
    }

    Map<String, dynamic> mapValue = {key: value};

    _preferences.setString(_appNamespace, jsonEncode(mapValue));
  }

  static Future<Object?> get([String key = _appNamespace]) async {
    if (_initialized == false) await _init();

    return _preferences.get(key);
  }
}
