import 'package:palette_generator/src/models.dart';

const int kDefaultMinColors = 4;

const int kDefaultMaxColors = 32;

const SortByPalette kDefaultSortByPalette = SortByPalette.name;

const Configurations kDefaultConfigurations = Configurations(
  minColors: kDefaultMinColors,
  maxColors: kDefaultMaxColors,
  sortByPalette: kDefaultSortByPalette,
);

const String kPaletteBox = "palette_box";

const String kPaletteList = "palettes";

const String kConfigs = "configs";
