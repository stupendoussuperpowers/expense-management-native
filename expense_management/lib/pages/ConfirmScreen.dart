import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class ConfirmScreen extends StatelessWidget {
  final String imagePath;
  final amount;
  final memo;
  final group;

  ConfirmScreen({
    required this.imagePath,
    required this.amount,
    required this.group,
    required this.memo,
  });

  Future<void> addTransaction() async {
    try {
      var a = {
        "image": await MultipartFile.fromFile(imagePath), //File(imagePath),
        "groupID": this.group,
        "memo": this.memo,
        "amount": this.amount,
        "user": "f9Lta3B8BniVB9zSP1iuG4",
      };

      var resp = await Dio().post(
        'http://10.0.2.2:1234/api/addTransaction/',
        data: FormData.fromMap(a),
      );
      print(resp.data);
    } catch (e) {
      print(e);
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

  Widget proofDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Receipt'),
        Image.file(
          File(imagePath),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          netCost(amount),
          memoDetails(memo),
          proofDetails(),
          ElevatedButton(
            onPressed: () async {
              var a = await addTransaction();
              // print(a);
            },
            child: Text('Confirm Transaction'),
          )
        ],
      ),
    );
  }
}
