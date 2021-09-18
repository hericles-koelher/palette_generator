import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/palette_generator_material.dart';
import 'package:palette_generator/screens/splash_screen.dart';
import 'package:palette_generator/utils/preferences_manager.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(PaletteGenerator());
}

class PaletteGenerator extends StatefulWidget {
  const PaletteGenerator({Key? key}) : super(key: key);

  @override
  State<PaletteGenerator> createState() => _PaletteGeneratorState();
}

class _PaletteGeneratorState extends State<PaletteGenerator>
    with WidgetsBindingObserver {
  late final PaletteStateNotifier _paletteStateNotifier;
  late final ColorListStateNotifier _colorListStateNotifier;
  late final SliderStateNotifier _sliderStateNotifier;
  bool _done = false;
  bool _error = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    PreferencesManager.get().then((json) {
      String data = json.toString();

      _paletteStateNotifier = data.isEmpty
          ? PaletteStateNotifier(List.empty(growable: true))
          : PaletteStateNotifier.fromJson(jsonDecode(data));

      _sliderStateNotifier = SliderStateNotifier();

      _colorListStateNotifier = ColorListStateNotifier();

      // Always start the application with a
      // 4 color random palette that will be used
      // by PaletteCreationPage.
      _colorListStateNotifier.createColorList(
          numberOfColors: _sliderStateNotifier.state);

      setState(() {
        _done = true;
      });
    }, onError: (Object error, Object stackTrace) {
      setState(() {
        _error = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    _paletteStateNotifier.dispose();
    _colorListStateNotifier.dispose();
    _sliderStateNotifier.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused)
      PreferencesManager.save(_paletteStateNotifier.toJson());

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Configure error message.
    if (_error) return Container();

    if (_done)
      return MultiProvider(
        providers: [
          StateNotifierProvider.value(value: _paletteStateNotifier),
          StateNotifierProvider.value(value: _colorListStateNotifier),
          StateNotifierProvider.value(value: _sliderStateNotifier),
        ],
        child: PaletteGeneratorMaterial(),
      );
    else
      return SplashScreen();
  }
}
