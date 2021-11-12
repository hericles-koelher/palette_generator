import 'dart:async';
import 'package:palette_generator/src/models.dart';
import 'package:state_notifier/state_notifier.dart';

class SliderStateNotifier extends StateNotifier<int> with LocatorMixin {
  late final StreamSubscription _settingsSubscription;

  SliderStateNotifier({required SettingsStateNotifier settings})
      : super(settings.state.minColors) {
    _settingsSubscription = settings.stream.listen((newSettings) {
      state = newSettings.minColors;
    });
  }

  void change(int value) => state = value;

  @override
  Future<void> dispose() async {
    await _settingsSubscription.cancel();

    super.dispose();
  }
}
