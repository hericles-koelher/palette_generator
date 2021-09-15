import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

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
          fontFamily: "Nunito",
          dividerColor: Colors.grey[400],
          iconTheme: IconThemeData(color: Colors.white),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(secondary: Colors.lime),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: "Nunito",
              color: Colors.grey[900],
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              fontFamily: "Nunito",
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
