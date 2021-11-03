import 'package:hive/hive.dart';

part 'settings_enum.g.dart';

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

@HiveType(typeId: 2)
enum FileType {
  @HiveField(0)
  gpl,

  @HiveField(1)
  jasc_pal,

  @HiveField(2)
  hex,
}
