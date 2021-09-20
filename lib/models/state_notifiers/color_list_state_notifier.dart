import 'package:palette/palette.dart';
import 'package:state_notifier/state_notifier.dart';

class ColorListStateNotifier extends StateNotifier<List<int>>
    with LocatorMixin {
  ColorListStateNotifier([List<int> state = const []]) : super(state);

  void createColorList({required int numberOfColors}) {
    var colorPalette = ColorPalette.random(numberOfColors);

    state = colorPalette.colors
        .map((colorModel) => _colorToRGBHex(colorModel))
        .toList();
  }

  static int _colorToRGBHex(ColorModel cm) {
    int red, blue, green, alpha;

    RgbColor rgbColor = cm.toRgbColor();

    red = rgbColor.red;
    blue = rgbColor.blue;
    green = rgbColor.green;
    alpha = rgbColor.alpha;

    return int.parse(
      "${alpha.toRadixString(16)}${red.toRadixString(16)}${blue.toRadixString(16)}${green.toRadixString(16)}",
      radix: 16,
    );
  }
}
