import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:state_notifier/state_notifier.dart';

class PaletteStateNotifier extends StateNotifier<List<PaletteInfo>>
    with LocatorMixin {
  PaletteStateNotifier(List<PaletteInfo> state) : super(state);

  void savePalette({required String paletteName, required List<Color> colors}) {
    var date = DateTime.now();
    debugPrint(date.toString());

    state.add(
      PaletteInfo(
        id: date.toString(),
        paletteName: paletteName,
        colors: colors,
        isFavorite: false,
      ),
    );

    // Vejamos se isso funciona...

    state = [...state]
      ..sort((pA, pB) => pA.paletteName.compareTo(pB.paletteName));
  }

  void updateList({required int fromIndex, required PaletteInfo newPalette}) {
    state.removeAt(fromIndex);
    state.add(newPalette);

    state = [...state]
      ..sort((pA, pB) => pA.paletteName.compareTo(pB.paletteName));
  }
}
