import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.group),
          title: Text('Group A'),
          subtitle: Text('Net: Rs. 1,430'),
        );
      },
    );
  }
}
