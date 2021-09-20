import 'package:palette_generator/utils/constants.dart';
import 'package:state_notifier/state_notifier.dart';

class SliderStateNotifier extends StateNotifier<int> with LocatorMixin {
  SliderStateNotifier() : super(kMinColorsPalette);

  void change(int value) => state = value;
}
