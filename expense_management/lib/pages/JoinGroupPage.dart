import 'package:flutter/material.dart';

class JoinGroupPage extends StatefulWidget {
  @override
  _JoinGroupPageState createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends State<JoinGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new group'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter Unique Group Code'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Create Group'),
          ),
        ],
      ),
    );
  }
}
