import 'package:flutter/material.dart';

class ThemeManager {
  static String get fontFamily => "Nunito";

  static Color get _defaultLightFontColor => Colors.grey[900]!;

  static Color get primaryColor => Colors.deepPurple;

  static TextTheme get lightTextTheme => TextTheme(
        headline5: TextStyle(
          color: _defaultLightFontColor,
          fontFamily: fontFamily,
          fontSize: 24,
          letterSpacing: 0.0,
        ),
        headline6: TextStyle(
          color: _defaultLightFontColor,
          fontFamily: fontFamily,
          fontSize: 20,
          letterSpacing: 0.15,
        ),
        subtitle1: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          letterSpacing: 0.15,
        ),
        bodyText1: TextStyle(
          fontFamily: fontFamily,
          color: _defaultLightFontColor,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
        bodyText2: TextStyle(
            fontFamily: fontFamily,
            color: Colors.grey[600],
            fontSize: 14,
            letterSpacing: 0.25),
      );

  static SnackBarThemeData get lightSnackBarThemeData => SnackBarThemeData(
        contentTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: Colors.white,
          fontSize: 18,
        ),
      );

  static TextButtonThemeData get lightTextButtonThemeData =>
      TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
            ),
          ),
        ),
      );

  static AppBarTheme get lightAppBarTheme => AppBarTheme(
        titleTextStyle: lightTextTheme.headline6!.copyWith(
          color: Colors.white,
        ),
        toolbarTextStyle: lightTextTheme.bodyText2!.copyWith(
          color: Colors.white,
        ),
      );

  static ElevatedButtonThemeData get lightElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            lightTextTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      );

  static TabBarTheme get lightTabBarTheme => TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: Colors.grey,
        labelStyle: lightTextTheme.headline6,
        unselectedLabelStyle: lightTextTheme.headline6,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2.0,
            color: primaryColor,
          ),
        ),
      );

  static ThemeData get light => ThemeData(
        dividerColor: Colors.grey[400],
        iconTheme: IconThemeData(color: Colors.white),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
        ).copyWith(secondary: Colors.lime),
        primaryColor: primaryColor,
        textTheme: lightTextTheme,
        snackBarTheme: lightSnackBarThemeData,
        textButtonTheme: lightTextButtonThemeData,
        appBarTheme: lightAppBarTheme,
        tabBarTheme: lightTabBarTheme,
      );
}
