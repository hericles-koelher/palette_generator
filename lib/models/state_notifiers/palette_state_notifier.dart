import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/sort_by_palette.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:undo/undo.dart';
import 'package:uuid/uuid.dart';

class PaletteStateNotifier extends StateNotifier<List<PaletteInfo>>
    with LocatorMixin {
  PaletteInfo? _lastDeleted;
  SortByPalette _sortByPalette;
  ChangeStack _changes = ChangeStack(limit: 1);
  Uuid _uuid = Uuid();

  PaletteStateNotifier({required List<PaletteInfo> palettes})
      : _sortByPalette = SortByPalette.name,
        super(palettes);

  void orderBy(SortByPalette option) {
    _sortByPalette = option;
    _sort();
  }

  void _sort() {
    int Function(PaletteInfo, PaletteInfo)? callback;

    switch (_sortByPalette) {
      case SortByPalette.name:
        callback = (pA, pB) => pA.paletteName.compareTo(pB.paletteName);
        break;
      case SortByPalette.creationDate:
        callback = (pA, pB) => pA.creationDate.compareTo(pB.creationDate);
        break;
      case SortByPalette.lastUpdate:
        callback = (pA, pB) => pA.lastUpdate.compareTo(pB.lastUpdate);
        break;
    }

    state = [...state]..sort(callback);
  }

  void savePalette({required String paletteName, required List<int> colors}) {
    var now = DateTime.now();
    String id = _uuid.v4();

    state.add(
      PaletteInfo(
        paletteName: paletteName,
        id: id,
        colors: colors,
        creationDate: now,
        lastUpdate: now,
      ),
    );

    _sort();
  }

  PaletteInfo updatePalette(
    PaletteInfo palette, {
    String? paletteName,
    bool? isFavorite,
  }) {
    PaletteInfo newPalette = palette.copyWith(
      paletteName: paletteName,
      isFavorite: isFavorite,
      lastUpdate: DateTime.now(),
    );

    state.remove(palette);
    state.add(newPalette);
    _sort();

    return newPalette;
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
