import 'package:flutter/material.dart';
import 'package:freshfood/src/public/styles.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline2: TextStyle(color: colorTitle),
      ),
    ),
  );
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: colorPrimary,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline2: TextStyle(color: mC),
      ),
    ),
  );
}
