import 'package:state_notifier/state_notifier.dart';
import '../../models.dart';

class SettingsStateNotifier extends StateNotifier<Settings> {
  SettingsStateNotifier({required Settings initialState}) : super(initialState);

  void sortBy(SortByPalette option) {
    state = state.copyWith(sortByPalette: option);
  }

  // TODO: criar metodos para outras alterações de configuração
}
