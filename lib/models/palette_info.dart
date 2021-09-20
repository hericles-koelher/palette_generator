import 'package:hive/hive.dart';

part 'palette_info.g.dart';

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
}
