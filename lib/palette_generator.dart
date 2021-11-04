import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/src/theme_manager.dart';
import 'package:provider/provider.dart';
import 'src/constants.dart';
import 'src/models.dart';
import 'src/screens.dart';

class PaletteGenerator extends StatefulWidget {
  final Box paletteBox;

  PaletteGenerator({Key? key})
      : paletteBox = Hive.box(kPaletteBox),
        super(key: key);

  @override
  State<PaletteGenerator> createState() => _PaletteGeneratorState();
}

class _PaletteGeneratorState extends State<PaletteGenerator> {
  late final PaletteStateNotifier _paletteStateNotifier;
  late final ColorListStateNotifier _colorListStateNotifier;
  late final SliderStateNotifier _sliderStateNotifier;
  late final SettingsStateNotifier _settingsStateNotifier;

  @override
  void initState() {
    _settingsStateNotifier = SettingsStateNotifier(
      paletteBox: widget.paletteBox,
    );

    _paletteStateNotifier = PaletteStateNotifier(
      paletteBox: widget.paletteBox,
      settings: _settingsStateNotifier,
    );

    _sliderStateNotifier = SliderStateNotifier(
      settings: _settingsStateNotifier,
    );

    _colorListStateNotifier = ColorListStateNotifier(
      settings: _settingsStateNotifier,
    );

    super.initState();
  }

  @override
  Future<void> dispose() async {
    await _paletteStateNotifier.dispose();
    await _settingsStateNotifier.dispose();
    await _colorListStateNotifier.dispose();
    await _sliderStateNotifier.dispose();

    await widget.paletteBox.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider.value(value: _paletteStateNotifier),
        StateNotifierProvider.value(value: _colorListStateNotifier),
        StateNotifierProvider.value(value: _sliderStateNotifier),
        StateNotifierProvider.value(value: _settingsStateNotifier),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Palette Generator",
        theme: ThemeManager.light,
        home: HomePage(),
      ),
    );
  }
}
