import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupNetDeets {
  final net;
  final transactions;

  GroupNetDeets({required this.net, required this.transactions});

  factory GroupNetDeets.fromJson(Map<String, dynamic> json) {
    return GroupNetDeets(net: json['net'], transactions: json['transactions']);
  }
}

class GroupNetPage extends StatelessWidget {
  final groupID;

  GroupNetPage({required this.groupID});

  Future<GroupNetDeets> getGroupNet() async {
    final a = await http
        .get(Uri.parse("http://10.0.2.2:1234/api/group/${this.groupID}"));
    //return jsonDecode(a.body);
    // return parseGroup(a.body);
    print("Hello there");
    print(a.body);
    return GroupNetDeets.fromJson(jsonDecode(a.body)["body"]);
    // jsonDecode(a.body);
  }

  Widget netCost(int net) {
    return SizedBox(
      width: 400,
      child: Text(
        'Rs. $net',
        style: TextStyle(
          color: net >= 0 ? Colors.green : Colors.red,
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget transactionHistory(var transactions) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${transactions[index]['memo']}'),
            subtitle: Text(
              'Rs. ${transactions[index]['amount']}',
              style: TextStyle(
                color: transactions[index]['amount'] > 0
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Details'),
      ),
      body: FutureBuilder<GroupNetDeets>(
        future: getGroupNet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print(snapshot.data?.net);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  netCost(snapshot.data?.net),
                  transactionHistory(snapshot.data?.transactions),
                ],
              );
            } else {
              return Center(child: Text("Error"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
