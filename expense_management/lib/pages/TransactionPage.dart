import 'package:expense_management/pages/ViewPicture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class TransactionPage extends StatelessWidget {
  final id;

  TransactionPage({required this.id});

  Future<dynamic> getTransaction() async {
    print(id);
    var a = await http.get(
      Uri.parse('http://10.0.2.2:1234/api/transaction/${this.id}'),
    );

    var b = jsonDecode(a.body);
    return b;
  }

  Widget priceCard(int net) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Amount',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$net',
                  style: TextStyle(
                    fontSize: 40,
                    color: net >= 0 ? Colors.greenAccent : Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' INR',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget infoCard(String heading, Widget body) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$heading',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            body,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
      ),
      body: FutureBuilder<dynamic>(
        future: getTransaction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var net = snapshot.data?["amount"];
              var imagePath = snapshot.data?["imagePath"];
              print(snapshot.data);
              return Center(
                child: Card(
                  elevation: 0,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        priceCard(net),
                        infoCard(
                          'Memo',
                          Text(
                            '${snapshot.data?["memo"]}',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        infoCard(
                          'Receipt',
                          imagePath != null
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewPicture(
                                          imagePath: imagePath,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'View Receipt',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'No Receipt Attached',
                                ),
                        ),
                        infoCard(
                          'Added On',
                          Text(
                            '${snapshot.data?["createdAt"]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("Error!");
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
