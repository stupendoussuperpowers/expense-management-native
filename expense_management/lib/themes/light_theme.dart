import 'package:flutter/material.dart';
import './app_color.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  accentColor: AppColor.accentColor,
  backgroundColor: AppColor.bodyColor,
  scaffoldBackgroundColor: AppColor.bodyColor,
  hintColor: AppColor.textColor,
  primaryColor: AppColor.bodyColor,
  primaryColorLight: AppColor.buttonBackgroundColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontFamily: "Rubik",
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Colors.black,
      onPrimary: Colors.white,
      elevation: 5,
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
);
