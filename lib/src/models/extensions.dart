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
