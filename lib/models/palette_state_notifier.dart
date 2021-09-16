import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/utils/preferences_manager.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:undo/undo.dart';

class PaletteStateNotifier extends StateNotifier<List<PaletteInfo>>
    with LocatorMixin {
  PaletteInfo? _lastDeleted;
  ChangeStack _changes = ChangeStack(limit: 1);

  PaletteStateNotifier(List<PaletteInfo> state) : super(state);

  PaletteStateNotifier.fromJson(Map<String, dynamic> json)
      : super(
          List.generate(
            json["number_of_palettes"],
            (index) => PaletteInfo.fromJson(json["palettes"][index]),
          ),
        );

  @override
  void dispose() {
    PreferencesManager.save(
      {
        "palette_state": {
          "palettes": state,
          "number_of_palettes": state.length,
        },
      },
    );
    super.dispose();
  }

  void savePalette({required String paletteName, required List<Color> colors}) {
    var date = DateTime.now();
    debugPrint(date.toString());

    state.add(
      PaletteInfo(
        id: date.toString(),
        paletteName: paletteName,
        colors: colors,
      ),
    );

    state = [...state]
      ..sort((pA, pB) => pA.paletteName.compareTo(pB.paletteName));
  }

  void deletePalette(String id) {
    try {
      _changes.add(
        Change(state, () {
          _lastDeleted = state.firstWhere((palette) => palette.id == id);

          state = [...state]..remove(_lastDeleted);
        }, (List<PaletteInfo> oldState) {
          state = oldState;
        }, description: "Delete palette with ID = $id"),
      );
    } catch (e) {
      String errorMsg = "Tried to delete a palette with invalid ID!";
      throw Exception(errorMsg);
    }
  }

  void undo() {
    if (_changes.canUndo) _changes.undo();
  }
}
