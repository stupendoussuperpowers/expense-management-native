import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  String groupName = '';

  Future<dynamic> createGroup() async {
    var a = await http.post(
      Uri.parse('http://10.0.2.2:1234/api/createGroup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "userID": "f9Lta3B8BniVB9zSP1iuG4",
          "groupName": groupName
        },
      ),
    );

    var b = jsonDecode(a.body);
    return b;
  }

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
            onChanged: (value) {
              setState(() {
                groupName = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Group Description'),
          ),
          ElevatedButton(
            onPressed: () async {
              var b = await createGroup();
              print(b["body"]);
            },
            child: Text('Create Group'),
          ),
        ],
      ),
    );
  }
}
