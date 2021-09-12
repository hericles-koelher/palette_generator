import 'package:flutter/painting.dart';

class PaletteInfo {
  final List<Color> colors;
  final String id;
  final String paletteName;
  final bool isFavorite;

  PaletteInfo({
    required this.id,
    required this.paletteName,
    required this.colors,
    required this.isFavorite,
  });
}
