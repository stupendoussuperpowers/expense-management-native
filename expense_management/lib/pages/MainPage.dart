import 'package:expense_management/pages/CreateGroupPage.dart';
import 'package:expense_management/pages/JoinGroupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget selectCard(String title, IconData icon, Widget destPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destPage),
        );
      },
      child: SizedBox(
        width: 150,
        height: 150,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(icon, size: 40), Text(title)],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selectCard(
          'Create Group',
          Icons.add,
          CreateGroupPage(),
        ),
        selectCard(
          'Join Group',
          Icons.group,
          JoinGroupPage(),
        )
      ],
    );
  }
}
