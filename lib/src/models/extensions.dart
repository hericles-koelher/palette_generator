import '../models.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ParsePaletteToString on SortByPalette {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last
        .split("_")
        .map((e) => e.capitalize())
        .join(" ");
  }
}

extension ParseFileTypeToString on FileType {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last
        .split("_")
        .map((e) => e.toUpperCase())
        .join(" ");
  }
}
