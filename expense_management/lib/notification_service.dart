import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String subtitle) async {
    await flutterLocalNotificationsPlugin.show(
      123,
      'Expense Management',
      subtitle,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "123",
          'Expense Management',
          'Alert',
        ),
      ),
    );
  }
}
