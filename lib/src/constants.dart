import 'package:palette_generator/src/models.dart';

const SortByPalette kDefaultSortingSchema = SortByPalette.creation_newest;

const Settings kDefaultConfigurations = Settings(
  minColors: 4,
  maxColors: 32,
  sortByPalette: kDefaultSortingSchema,
  fileType: FileType.gpl,
);

const String kPaletteBox = "palette_box";

const String kPaletteList = "palettes";

const String kSettings = "settings";

const int kMinColors = 1;

const int kMaxColors = 128;

const int kNameMaxLength = 25;

const double kVerticalPadding = 40;

const double kHorizontalPadding = 20;
