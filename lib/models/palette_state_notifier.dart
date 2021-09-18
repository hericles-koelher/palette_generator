import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:undo/undo.dart';
import 'package:uuid/uuid.dart';

enum SortByPalette {
  name,
  creationDate,
  lastUpdate,
}

class PaletteStateNotifier extends StateNotifier<List<PaletteInfo>>
    with LocatorMixin {
  PaletteInfo? _lastDeleted;
  SortByPalette _sortByPalette = SortByPalette.lastUpdate;
  ChangeStack _changes = ChangeStack(limit: 1);
  Uuid _uuid = Uuid();

  PaletteStateNotifier(List<PaletteInfo> state)
      : _sortByPalette = SortByPalette.name,
        super(state);

  PaletteStateNotifier.fromJson(Map<String, dynamic> json)
      : _sortByPalette = _sortByPaletteFromString(json["sort_by_palette"]),
        super(
          List.generate(
            json["number_of_palettes"],
            (index) => PaletteInfo.fromJson(json["palettes"][index]),
          ),
        );

  Map<String, dynamic> toJson() => {
        "palettes": state,
        "number_of_palettes": state.length,
        "sort_by_palette": _sortByPalette.toString(),
      };

  static SortByPalette _sortByPaletteFromString(String str) {
    return SortByPalette.values.firstWhere(
      (element) => element.toString() == str,
      orElse: () => SortByPalette.lastUpdate,
    );
  }

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

  void savePalette({required String paletteName, required List<Color> colors}) {
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

  void updatePalette(
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
