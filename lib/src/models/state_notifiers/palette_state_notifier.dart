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

  PaletteStateNotifier({
    required Box paletteBox,
    required SettingsStateNotifier settings,
  })  : _sortByPalette = settings.state.sortByPalette,
        super(
          paletteBox
              .get(kPaletteList, defaultValue: List.empty(growable: true))
              .cast<PaletteInfo>(),
        ) {
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
        callback = (pA, pB) => pA.name.compareTo(pB.name);
        break;
      case SortByPalette.name_descending:
        callback = (pA, pB) => pB.name.compareTo(pA.name);
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

  void savePalette(
      {required String name, required List<int> colors, String? description}) {
    var now = DateTime.now();
    String id = _uuid.v4();

    state.add(
      PaletteInfo(
        name: name,
        id: id,
        colors: colors,
        creationDate: now,
        description: description,
      ),
    );

    _sort();
  }

  PaletteInfo updatePalette(
    PaletteInfo palette, {
    String? name,
    bool? isFavorite,
    String? description,
  }) {
    PaletteInfo newPalette = palette.copyWith(
      name: name,
      isFavorite: isFavorite,
      description: description,
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
