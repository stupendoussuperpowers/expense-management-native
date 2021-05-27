import 'package:flutter/material.dart';
import './app_color.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: AppColor.accentColorDark,
  backgroundColor: AppColor.bodyColorDark,
  scaffoldBackgroundColor: AppColor.bodyColorDark,
  hintColor: AppColor.textColor,
  primaryColorLight: AppColor.buttonBackgroundColorDark,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontFamily: "Rubik",
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
  ),
);
