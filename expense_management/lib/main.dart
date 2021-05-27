import 'package:expense_management/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'pages/HomePage.dart';
import './pages/LoginPage.dart';

void main() {
  runApp(MaterialApp(
    home : LoginPage(),
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
  ),);
}

