import 'package:hive/hive.dart';
import '../models.dart';

part 'configurations.g.dart';

@HiveType(typeId: 2)
class Configurations {
  @HiveField(0)
  final int minColors;

  @HiveField(1)
  final int maxColors;

  @HiveField(2)
  final SortByPalette sortByPalette;

  const Configurations({
    required this.minColors,
    required this.maxColors,
    required this.sortByPalette,
  })  : assert(minColors > 0),
        assert(maxColors > minColors && maxColors <= 128);

  Configurations copyWith({
    int? minColors,
    int? maxColors,
    SortByPalette? sortByPalette,
  }) {
    return Configurations(
      minColors: minColors ?? this.minColors,
      maxColors: maxColors ?? this.maxColors,
      sortByPalette: sortByPalette ?? this.sortByPalette,
    );
  }
}
