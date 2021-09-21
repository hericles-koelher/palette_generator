import 'package:state_notifier/state_notifier.dart';
import '../../models.dart';

class ConfigurationsStateNotifier extends StateNotifier<Configurations> {
  ConfigurationsStateNotifier({required Configurations initialState})
      : super(initialState);

  void sortBy(SortByPalette option) {
    state = state.copyWith(sortByPalette: option);
  }

  // TODO: criar metodos para outras alterações de configuração
}
