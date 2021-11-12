import '../models.dart';

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

extension Capitalize on String {
  String toCapitalized() {
    return this
        .split(" ")
        .map((word) => "${word[0].toUpperCase()}${word.substring(1)}")
        .join(" ");
  }
}
