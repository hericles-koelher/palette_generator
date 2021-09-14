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

  @override
  String toString() {
    return "ID: $id, PALETTE_NAME: $paletteName, COLORS: [$colors]";
  }
}
