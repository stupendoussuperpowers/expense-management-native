import 'dart:convert';

import 'package:expense_management/pages/ResultPage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ConfirmScreen extends StatelessWidget {
  final String imagePath;
  final amount;
  final memo;
  final group;
  final recurring;

  ConfirmScreen({
    required this.imagePath,
    required this.amount,
    required this.group,
    required this.memo,
    required this.recurring,
  });

  Future<dynamic> addTransaction() async {
    try {
      var a = {
        "image": await MultipartFile.fromFile(imagePath), //File(imagePath),
        "groupID": this.group,
        "memo": this.memo,
        "amount": this.amount,
        "user": "f9Lta3B8BniVB9zSP1iuG4",
        "recurring": recurring,
      };

      var resp = await Dio().post(
        'http://10.0.2.2:1234/api/addTransaction/',
        data: FormData.fromMap(a),
      );
      print(resp.data);
      return resp.data;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Widget netCost(int net) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Amount'),
        Text(
          'Rs. $net',
          style: TextStyle(
            color: net >= 0 ? Colors.green : Colors.red,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget memoDetails(String memo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Memo'),
        Text(
          '$memo',
          style: TextStyle(
            // color: net >= 0 ? Colors.green : Colors.red,
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
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
        title: Text('Confirm Page'),
      ),
      body: Center(
        child: Card(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                priceCard(amount),
                infoCard(
                  'Memo',
                  Text(
                    '$memo',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                infoCard(
                  'Receipt',
                  Image.file(
                    File(imagePath),
                    height: 200,
                    width: 200,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var a = await addTransaction();
                    // print(a);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          success: a["success"],
                          message: a["body"],
                        ),
                      ),
                    );
                  },
                  child: Text('Confirm Transaction'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
