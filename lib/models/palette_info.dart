import 'dart:convert';

import 'package:flutter/painting.dart';

class PaletteInfo {
  final List<Color> colors;
  final String id;
  final String paletteName;

  PaletteInfo({
    required this.id,
    required this.paletteName,
    required this.colors,
  });

  PaletteInfo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        paletteName = json["palette_name"],
        colors = json["colors"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "palette_name": paletteName,
        "colors": jsonEncode(colors),
      };

  @override
  String toString() {
    return "ID: $id, PALETTE_NAME: $paletteName, COLORS: [$colors]";
  }
}
