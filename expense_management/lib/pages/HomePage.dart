import 'package:expense_management/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:expense_management/pages/MainPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './AddTransaction.dart';
import './GroupsPage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  // TODO: Replace with imports from these pages

  @override
  Widget build(BuildContext context) {
    var pageLists = [
      MainPage(), //Text('Home Page'),
      AddTransaction(), //Text('Add Transaction Page'),
      GroupsPage(), //Text('View Groups Page'),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: Container(),
          actions: [
            GestureDetector(
              child: Icon(Icons.notifications),
              onTap: () async {
                var f = NotificationService();
                await f.init();
                f.showNotification('Test', 'Added 12 INR');
              },
            )
          ],
        ),
        body: Center(child: pageLists[_selectedTab]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (value) => setState(() {
            _selectedTab = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: 'Add Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Colors.black,
              ),
              label: 'View Groups',
            ),
          ],
        ),
      ),
    );
  }
}
