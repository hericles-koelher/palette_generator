import 'dart:async';

import 'package:hive/hive.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:undo/undo.dart';
import 'package:uuid/uuid.dart';
import '../../models.dart';

class PaletteStateNotifier extends StateNotifier<List<PaletteInfo>>
    with LocatorMixin {
  final ChangeStack _changes = ChangeStack(limit: 1);
  final Uuid _uuid = Uuid();
  late final StreamSubscription _settingsSubscription;
  late final StreamSubscription _stateSubscription;
  PaletteInfo? _lastDeleted;
  SortByPalette _sortByPalette;

  PaletteStateNotifier(
      {required Box paletteBox,
      required List<PaletteInfo> palettes,
      required SettingsStateNotifier settings})
      : _sortByPalette = settings.state.sortByPalette,
        super(palettes) {
    _settingsSubscription = settings.stream.listen((newSettings) {
      _sortByPalette = newSettings.sortByPalette;
      _sort();
    });

    _stateSubscription = stream.listen((newPaletteList) async {
      await paletteBox.put(kPaletteList, newPaletteList);
    });
  }

  void _sort() {
    int Function(PaletteInfo, PaletteInfo)? callback;

    switch (_sortByPalette) {
      case SortByPalette.name_ascending:
        callback = (pA, pB) => pA.paletteName.compareTo(pB.paletteName);
        break;
      case SortByPalette.name_descending:
        callback = (pA, pB) => pB.paletteName.compareTo(pA.paletteName);
        break;
      case SortByPalette.creation_oldest:
        callback = (pA, pB) => pA.creationDate.compareTo(pB.creationDate);
        break;
      case SortByPalette.creation_newest:
        callback = (pA, pB) => pB.creationDate.compareTo(pA.creationDate);
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
        Change(
          state,
          () {
            _lastDeleted = state.firstWhere((palette) => palette.id == id);

            state = [...state]..remove(_lastDeleted);
          },
          (List<PaletteInfo> oldState) {
            state = oldState;
          },
        ),
      );
    } catch (e) {
      String errorMsg = "Tried to delete a palette with invalid ID!";
      throw Exception(errorMsg);
    }
  }

  void undo() {
    if (_changes.canUndo) _changes.undo();
  }

  @override
  Future<void> dispose() async {
    await _settingsSubscription.cancel();
    await _stateSubscription.cancel();

    super.dispose();
  }
}
