import 'package:flutter/material.dart';

class Themes {

  static final MaterialColor jhPrimaryColor =  Colors.indigo;
  static final MaterialColor jhSecondaryColor =  Colors.pink;
  static final MaterialAccentColor jhPrimaryColorAccent =  Colors.indigoAccent;
  static final MaterialAccentColor jhSecondaryColorAccent =  Colors.pinkAccent;

  static final double header1FontSize =  30.0;
  static final double header3FontSize =  25.0;
  static final double baseFontSize =  15.0;

  static final String jhFont =  'Roboto';

  static final ThemeData jhLight = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: jhFont,
    primaryColor: jhPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      errorStyle: TextStyle(color: Colors.red),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: jhPrimaryColor,
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme.light(primary: jhPrimaryColor),
      height: 50,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: header1FontSize, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: header1FontSize, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: header3FontSize, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: header3FontSize, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black, fontSize: baseFontSize),
      bodyMedium: TextStyle(color: Colors.white, fontSize: baseFontSize),
      labelLarge: TextStyle(
        fontSize: baseFontSize,
      ),
    ), colorScheme: ColorScheme.light(
        primary: jhPrimaryColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        //primaryVariant: jhPrimaryColorAccent,
        secondary: jhSecondaryColor,
        //secondaryVariant: jhSecondaryColorAccent,
        error: Colors.red).copyWith(error: Colors.red),
  );
}
