import 'package:flutter/material.dart';
import './app_color.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: AppColor.accentColorDark,
  backgroundColor: AppColor.bodyColorDark,
  scaffoldBackgroundColor: AppColor.bodyColorDark,
  hintColor: AppColor.textColor,
  primaryColor: AppColor.bodyColorDark,
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
      elevation :5,
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
);
