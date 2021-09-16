import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static Future<SharedPreferences> getPreferences() async {
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey("palette_state")) {
      Map<String, dynamic> json = {
        "palettes": [],
        "number_of_palettes": 0,
      };
      preferences.setString(
        "palette_state",
        json.toString(),
      );
    }

    return preferences;
  }

  static void save(Map<String, dynamic> json) async {
    final preferences = await SharedPreferences.getInstance();

    json.forEach(
      (key, value) {
        preferences.setString(key, jsonEncode(value));
      },
    );
  }
}
