import 'package:palette_generator/src/constants.dart';
import 'package:state_notifier/state_notifier.dart';

class SliderStateNotifier extends StateNotifier<int> with LocatorMixin {
  SliderStateNotifier() : super(kDefaultMinColors);

  void change(int value) => state = value;
}
