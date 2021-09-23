import 'package:hive/hive.dart';

part 'sort_by_palette.g.dart';

@HiveType(typeId: 1)
enum SortByPalette {
  @HiveField(0)
  name_ascending,

  @HiveField(1)
  name_descending,

  @HiveField(2)
  creation_ascending,

  @HiveField(3)
  creation_descending,

  @HiveField(4)
  last_update,
}
