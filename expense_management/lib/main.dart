import 'dart:convert';

import 'package:expense_management/notification_service.dart';
import 'package:expense_management/themes/app_theme.dart';
import 'package:flutter/material.dart';
import './pages/LoginPage.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  try {
    final _channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:3000'));
    _channel.stream.listen((event) async {
      print(event);
      var f = NotificationService();
      await f.init();
      var b = jsonDecode(event);

      print(b["subtitle"]);
      f.showNotification(b["title"] ?? 'Null', b["subtitle"] ?? 'Null');
    });
  } catch (e) {
    print(e);
  }

  runApp(
    MaterialApp(
      home: LoginPage(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    ),
  );
}
