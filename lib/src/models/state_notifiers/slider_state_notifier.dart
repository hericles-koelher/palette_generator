import 'package:state_notifier/state_notifier.dart';

class SliderStateNotifier extends StateNotifier<int> with LocatorMixin {
  SliderStateNotifier({required int initialValue}) : super(initialValue);

  void change(int value) => state = value;
}
