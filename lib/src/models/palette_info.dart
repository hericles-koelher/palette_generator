import 'package:hive/hive.dart';

part 'palette_info.g.dart';

// TODO: add description.
@HiveType(typeId: 0)
class PaletteInfo {
  @HiveField(0)
  final String paletteName;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final List<int> colors;

  @HiveField(3)
  final DateTime creationDate;

  @HiveField(4)
  final DateTime lastUpdate;

  @HiveField(5)
  final bool isFavorite;

  PaletteInfo({
    required this.paletteName,
    required this.id,
    required this.colors,
    required this.creationDate,
    required this.lastUpdate,
    this.isFavorite = false,
  });

  PaletteInfo copyWith({
    String? paletteName,
    String? id,
    List<int>? colors,
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

  String toGpl() {
    String str = "Gimp Palette\n";

    str += "Name: $paletteName\n";

    str += "Colors: ${colors.length}\n";

    for (int i = 0; i < colors.length; i++) {
      int colorValue = colors[i];

      int r = (colorValue >> 16) & 0xFF;
      int g = (colorValue >> 8) & 0xFF;
      int b = (colorValue >> 0) & 0xFF;

      str += "$r $g $b\t${colorValue.toRadixString(16).substring(2)}\n";
    }

    return str;
  }

  String toJascPal() {
    String str = "JASC-PAL\n0100\n";

    str += "${colors.length}\n";

    for (int i = 0; i < colors.length; i++) {
      int colorValue = colors[i];

      int r = (colorValue >> 16) & 0xFF;
      int g = (colorValue >> 8) & 0xFF;
      int b = (colorValue >> 0) & 0xFF;

      str += "$r $g $b\n";
    }

    return str;
  }

  String toHex() {
    String str = "";

    for (int i = 0; i < colors.length; i++) {
      int colorValue = colors[i];

      str += "${colorValue.toRadixString(16).substring(2).padLeft(6, "0")}\n";
    }

    return str;
  }
}
