import 'package:flutter/material.dart';
import 'package:palette_generator/screens/home_page.dart';

class PaletteGeneratorMaterial extends StatelessWidget {
  const PaletteGeneratorMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
