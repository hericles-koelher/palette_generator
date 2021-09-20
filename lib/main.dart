import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palette_generator/models.dart';
import 'package:palette_generator/palette_generator_material.dart';
import 'package:palette_generator/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PaletteInfoAdapter());

  await Hive.openBox(kPaletteBox);

  runApp(PaletteGenerator());
}

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

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    widget.paletteBox.clear();

    List<PaletteInfo> paletteList = widget.paletteBox
        .get(
          kPaletteList,
          defaultValue: List.empty(growable: true),
        )
        .cast<PaletteInfo>();

    _paletteStateNotifier = PaletteStateNotifier(palettes: paletteList);

    _sliderStateNotifier = SliderStateNotifier();

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

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused)
      widget.paletteBox.put(kPaletteList, _paletteStateNotifier.state);

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider.value(value: _paletteStateNotifier),
        StateNotifierProvider.value(value: _colorListStateNotifier),
        StateNotifierProvider.value(value: _sliderStateNotifier),
      ],
      child: PaletteGeneratorMaterial(),
    );
  }
}
