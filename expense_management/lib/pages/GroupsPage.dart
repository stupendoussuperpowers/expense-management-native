import 'dart:convert';

import 'package:expense_management/pages/GroupNetPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Group {
  final groupName;
  final groupID;

  Group({required this.groupName, required this.groupID});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(groupName: json['groupName'], groupID: json['groupID']);
  }
}

class GroupsPage extends StatelessWidget {
  Future<List<Group>> getGroups() async {
    print("Here I am!");
    //final client = http.Client();
    final a = await http.get(Uri.parse(
        "http://10.0.2.2:1234/api/userGroups/f9Lta3B8BniVB9zSP1iuG4"));
    //return jsonDecode(a.body);
    return parseGroup(a.body);
  }

  List<Group> parseGroup(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    return parsed["body"].map<Group>((json) => Group.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Group>>(
      future: getGroups(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupNetPage(
                          groupID: snapshot.data?[index].groupID,
                        ),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.label_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    "${snapshot.data?[index].groupName}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                );
              },
            );
          } else {
            return Text("Error");
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
