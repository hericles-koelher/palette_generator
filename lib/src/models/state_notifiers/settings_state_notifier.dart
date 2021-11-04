import 'dart:async';

import 'package:hive/hive.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../models.dart';

class SettingsStateNotifier extends StateNotifier<Settings> {
  late final StreamSubscription _stateSubscription;

  SettingsStateNotifier({required Box paletteBox})
      : super(
          paletteBox.get(
            kSettings,
            defaultValue: kDefaultConfigurations,
          ),
        ) {
    _stateSubscription = stream.listen((newSettings) async {
      await paletteBox.put(kSettings, newSettings);
    });
  }

  void sortBy(SortByPalette option) {
    state = state.copyWith(sortByPalette: option);
  }

  void changeExportFileFormat(FileType type) {
    state = state.copyWith(fileType: type);
  }

  void setMinColors(int value) {
    state = state.copyWith(minColors: value);
  }

  void setMaxColors(int value) {
    state = state.copyWith(maxColors: value);
  }

  @override
  Future<void> dispose() async {
    await _stateSubscription.cancel();

    super.dispose();
  }
}
