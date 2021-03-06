import 'package:hive/hive.dart';

part 'palette_info.g.dart';

@HiveType(typeId: 0)
class PaletteInfo {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final List<int> colors;

  @HiveField(3)
  final DateTime creationDate;

  @HiveField(5)
  final bool isFavorite;

  @HiveField(6)
  final String? description;

  PaletteInfo({
    required this.name,
    required this.id,
    required this.colors,
    required this.creationDate,
    this.isFavorite = false,
    this.description,
  });

  PaletteInfo copyWith({
    String? name,
    String? id,
    List<int>? colors,
    bool? isFavorite,
    DateTime? creationDate,
    String? description,
  }) {
    return PaletteInfo(
      name: name ?? this.name,
      id: id ?? this.id,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
      creationDate: creationDate ?? this.creationDate,
      description: description ?? this.description,
    );
  }

  String toGpl() {
    String str = "Gimp Palette\n";

    str += "#Palette Name: $name\n";

    str += "#Description: $description\n";

    str += "#Colors: ${colors.length}\n";

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
