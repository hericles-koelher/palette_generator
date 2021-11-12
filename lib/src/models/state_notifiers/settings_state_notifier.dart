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

  void updateSettings({
    int? minColors,
    int? maxColors,
    SortByPalette? sortByPalette,
    FileType? fileType,
    String? language,
  }) {
    state = state.copyWith(
      minColors: minColors,
      maxColors: maxColors,
      sortByPalette: sortByPalette,
      fileType: fileType,
      language: language,
    );
  }

  @override
  Future<void> dispose() async {
    await _stateSubscription.cancel();

    super.dispose();
  }
}
