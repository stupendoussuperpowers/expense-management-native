import 'package:expense_management/pages/ResultPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JoinGroupPage extends StatefulWidget {
  @override
  _JoinGroupPageState createState() => _JoinGroupPageState();
}

class _JoinGroupPageState extends State<JoinGroupPage> {
  String groupID = '';

  Future<dynamic> joinGroup() async {
    var a = await http.post(
      Uri.parse('http://10.0.2.2:1234/api/joinGroup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "userID": "f9Lta3B8BniVB9zSP1iuG4",
          "groupID": groupID,
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Group Name",
                ),
                onChanged: (value) {
                  setState(() {
                    groupID = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var b = await joinGroup();
                print(b);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      success: b["success"],
                      message: b["body"],
                    ),
                  ),
                );
              },
              child: Text('Join Group'),
            ),
          ],
        ),
      ),
    );
  }
}
