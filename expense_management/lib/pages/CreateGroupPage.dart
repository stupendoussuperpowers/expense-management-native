import 'package:flutter/material.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a new group'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter Group Name'),
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Group Description'),
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
