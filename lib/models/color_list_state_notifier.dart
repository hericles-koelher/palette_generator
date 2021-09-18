import 'package:flutter/painting.dart';
import 'package:palette/palette.dart';
import 'package:state_notifier/state_notifier.dart';

class ColorListStateNotifier extends StateNotifier<List<Color>>
    with LocatorMixin {
  ColorListStateNotifier([List<Color> state = const []]) : super(state);

  void createColorList({required int numberOfColors}) {
    var colorPalette = ColorPalette.random(numberOfColors);

    state = colorPalette.colors
        .map((colorModel) => _colorModelToColor(colorModel))
        .toList();
  }

  static Color _colorModelToColor(ColorModel cm) {
    int red, blue, green, alpha;

    RgbColor rgbColor = cm.toRgbColor();

    red = rgbColor.red;
    blue = rgbColor.blue;
    green = rgbColor.green;
    alpha = rgbColor.alpha;

    return Color.fromARGB(alpha, red, green, blue);
  }
}
