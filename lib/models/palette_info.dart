import 'package:flutter/painting.dart';

class PaletteInfo {
  final String paletteName;
  final String id;
  final List<Color> colors;
  final DateTime creationDate;
  final DateTime lastUpdate;
  final bool isFavorite;

  PaletteInfo({
    required this.paletteName,
    required this.id,
    required this.colors,
    required this.creationDate,
    required this.lastUpdate,
    this.isFavorite = false,
  });

  PaletteInfo.fromJson(Map<String, dynamic> json)
      : paletteName = json["palette_name"],
        id = json["id"],
        colors = (json["colors"] as List)
            .map((colorValue) => Color(colorValue))
            .toList(),
        isFavorite = json["is_favorite"],
        creationDate = DateTime.parse(json["creation_date"]),
        lastUpdate = DateTime.parse(json["last_update"]);

  Map<String, dynamic> toJson() => {
        "palette_name": paletteName,
        "id": id,
        "colors": _colorsToJson(),
        "is_favorite": isFavorite,
        "creation_date": creationDate.toString(),
        "last_update": lastUpdate.toString(),
      };

  PaletteInfo copyWith({
    String? paletteName,
    String? id,
    List<Color>? colors,
    bool? isFavorite,
    DateTime? creationDate,
    DateTime? lastUpdate,
  }) {
    return PaletteInfo(
      paletteName: paletteName ?? this.paletteName,
      id: id ?? this.id,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
      creationDate: creationDate ?? this.creationDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  List<int> _colorsToJson() => colors.map((color) => color.value).toList();
}
