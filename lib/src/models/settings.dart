import 'package:hive/hive.dart';
import 'package:palette_generator/src/constants.dart';
import '../models.dart';

part 'settings.g.dart';

@HiveType(typeId: 1)
class Settings {
  @HiveField(0)
  final int minColors;

  @HiveField(1)
  final int maxColors;

  @HiveField(2)
  final SortByPalette sortByPalette;

  @HiveField(3)
  final FileType fileType;

  @HiveField(4)
  final String? language;

  const Settings(
      {required this.minColors,
      required this.maxColors,
      this.sortByPalette = SortByPalette.creation_newest,
      this.fileType = FileType.gpl,
      this.language})
      : assert(minColors >= kMinColors),
        assert(maxColors > minColors),
        assert(maxColors <= kMaxColors);

  Settings copyWith({
    int? minColors,
    int? maxColors,
    SortByPalette? sortByPalette,
    FileType? fileType,
    String? language,
  }) {
    return Settings(
      minColors: minColors ?? this.minColors,
      maxColors: maxColors ?? this.maxColors,
      sortByPalette: sortByPalette ?? this.sortByPalette,
      fileType: fileType ?? this.fileType,
      language: language ?? this.language,
    );
  }
}
