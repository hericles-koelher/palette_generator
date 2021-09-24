import 'package:hive/hive.dart';

part 'sort_by_palette.g.dart';

@HiveType(typeId: 1)
enum SortByPalette {
  @HiveField(0)
  name_ascending,

  @HiveField(1)
  name_descending,

  @HiveField(2)
  creation_oldest,

  @HiveField(3)
  creation_newest,
}
