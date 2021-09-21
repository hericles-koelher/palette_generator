import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:hive/hive.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Palette Generator",
        theme: ThemeData(
          fontFamily: "Nunito",
          dividerColor: Colors.grey[400],
          iconTheme: IconThemeData(color: Colors.white),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(secondary: Colors.lime),
          primaryColor: Colors.deepPurple[600],
          // bottomAppBarColor: Colors.deepPurple,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: "Nunito",
              color: Colors.grey[900],
              fontSize: 20,
            ),
            bodyText2: TextStyle(
              fontFamily: "Nunito",
              color: Colors.grey[600],
              fontSize: 18,
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: TextStyle(
              fontFamily: "Nunito",
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontFamily: "Nunito",
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
