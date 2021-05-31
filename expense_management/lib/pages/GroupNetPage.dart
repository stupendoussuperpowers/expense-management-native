import 'dart:convert';

import 'package:expense_management/pages/TransactionPage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroupNetDeets {
  final net;
  final transactions;
  final recurring;
  final recNet;

  GroupNetDeets(
      {required this.net,
      required this.transactions,
      required this.recNet,
      required this.recurring});

  factory GroupNetDeets.fromJson(Map<String, dynamic> json) {
    return GroupNetDeets(
      net: json['net'],
      transactions: json['transactions'],
      recNet: json['recNet'],
      recurring: json['recurring'],
    );
  }
}

class GroupNetPage extends StatelessWidget {
  final groupID;
  //TabController _controller;

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

  Widget netCost(int net, int recNet) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Total Balance'),
            SizedBox(
              width: 400,
              child: Text(
                'Rs. $net',
                style: TextStyle(
                  color: net >= 0 ? Colors.green : Colors.red,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text('Monthly Net'),
            SizedBox(
              width: 400,
              child: Text(
                'Rs. $recNet',
                style: TextStyle(
                  color: recNet >= 0 ? Colors.green : Colors.red,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listTrans(var transactions) {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            color: transactions[index]['amount'] > 0
                ? Colors.lightGreen
                : Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ListTile(
                trailing: Icon(Icons.delete_forever_rounded),
                title: Text('${transactions[index]['memo']}'),
                subtitle: Text(
                  'Rs. ${transactions[index]['amount']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionPage(
                      id: transactions[index]["_id"],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget transactionHistory(var transactions, var recurring) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: null,
            leading: Container(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.payment_rounded,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Transactions',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.repeat_rounded,
                    color: Colors.black,
                  ),
                  child: Text(
                    'Recurring',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              listTrans(transactions),
              listTrans(recurring),
            ],
          ),
        ),
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
              print(snapshot.data?.transactions);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  netCost(snapshot.data?.net, snapshot.data?.recNet),
                  transactionHistory(
                    snapshot.data?.transactions,
                    snapshot.data?.recurring,
                  ),
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
