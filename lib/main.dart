import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PaletteGenerator());
}

class PaletteGenerator extends StatelessWidget {
  const PaletteGenerator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<PaletteStateNotifier, List<PaletteInfo>>(
          create: (context) => PaletteStateNotifier(
            List.empty(growable: true),
          ),
        ),
        StateNotifierProvider<ColorListStateNotifier, List<Color>>(
          create: (context) => ColorListStateNotifier(
            List.empty(),
          ),
        ),
        StateNotifierProvider<SliderStateNotifier, int>(
          create: (context) => SliderStateNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Palette Generator",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          primaryColorDark: Colors.deepPurple[700],
          primaryColorLight: Colors.deepPurple[100],
          accentColor: Colors.lime,
          dividerColor: Colors.grey[400],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        home: HomePage(),
      ),
    );
  }
}
