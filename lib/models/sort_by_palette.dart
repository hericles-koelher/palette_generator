import 'package:hive/hive.dart';

part 'sort_by_palette.g.dart';

@HiveType(typeId: 1)
enum SortByPalette {
  @HiveField(0)
  name,

  @HiveField(1)
  creationDate,

  @HiveField(2)
  lastUpdate,
}
