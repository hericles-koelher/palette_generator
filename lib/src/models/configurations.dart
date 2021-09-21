import 'package:hive/hive.dart';
import '../models.dart';

part 'configurations.g.dart';

// TODO: implementar state notifier dessa classe
@HiveType(typeId: 2)
class Configurations {
  @HiveField(0, defaultValue: 4)
  final int minColors;

  @HiveField(1, defaultValue: 32)
  final int maxColors;

  @HiveField(2, defaultValue: SortByPalette.lastUpdate)
  final SortByPalette sortByPalette;

  Configurations({
    required this.minColors,
    required this.maxColors,
    required this.sortByPalette,
  })  : assert(minColors > 0),
        assert(maxColors > minColors && maxColors <= 128);
}
