import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/src/ThemeManager.dart';
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

class _PaletteGeneratorState extends State<PaletteGenerator>
    with WidgetsBindingObserver {
  late final PaletteStateNotifier _paletteStateNotifier;
  late final ColorListStateNotifier _colorListStateNotifier;
  late final SliderStateNotifier _sliderStateNotifier;
  late final ConfigurationsStateNotifier _configurationsStateNotifier;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    List<PaletteInfo> paletteList = widget.paletteBox
        .get(
          kPaletteList,
          defaultValue: List.empty(growable: true),
        )
        .cast<PaletteInfo>();

    Configurations config = widget.paletteBox.get(
      kConfigs,
      defaultValue: kDefaultConfigurations,
    );

    _configurationsStateNotifier =
        ConfigurationsStateNotifier(initialState: config);

    _paletteStateNotifier = PaletteStateNotifier(
      palettes: paletteList,
      sortBy: config.sortByPalette,
    );

    _sliderStateNotifier = SliderStateNotifier(
      initialValue: config.minColors,
    );

    _colorListStateNotifier = ColorListStateNotifier();

    // Always start the application with a
    // 4 color random palette that will be used
    // by PaletteCreationPage.
    _colorListStateNotifier.createColorList(
      numberOfColors: _sliderStateNotifier.state,
    );

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    _paletteStateNotifier.dispose();
    _colorListStateNotifier.dispose();
    _sliderStateNotifier.dispose();
    _configurationsStateNotifier.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.paletteBox.put(kPaletteList, _paletteStateNotifier.state);
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider.value(value: _paletteStateNotifier),
        StateNotifierProvider.value(value: _colorListStateNotifier),
        StateNotifierProvider.value(value: _sliderStateNotifier),
        StateNotifierProvider.value(value: _configurationsStateNotifier),
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
