import 'package:palette_generator/src/models.dart';

const Settings kDefaultConfigurations = Settings(
  minColors: 4,
  maxColors: 32,
  sortByPalette: SortByPalette.creation_newest,
  fileType: FileType.gpl,
);

const String kPaletteBox = "palette_box";

const String kPaletteList = "palettes";

const String kConfigs = "configs";

const int kMinColors = 1;

const int kMaxColors = 128;
