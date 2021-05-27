import 'package:flutter/material.dart';
import 'package:expense_management/pages/MainPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './AddTransaction.dart';
import './GroupsPage.dart';

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
      Text('Settings Page'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: pageLists[_selectedTab]),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedTab,
        height: 50.0,
        color: Theme.of(context).primaryColorLight,
        backgroundColor: Theme.of(context).backgroundColor,
        buttonBackgroundColor: Theme.of(context).accentColor,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 800),
        onTap: (value) => setState(() {
          _selectedTab = value;
        }),
        items: <Widget>[
          Icon(Icons.home, size: 30, semanticLabel: "Home",),
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.settings, size: 30),
        ],
      ),
    );
  }
}
