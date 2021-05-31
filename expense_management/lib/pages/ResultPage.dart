import 'package:expense_management/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultPage extends StatelessWidget {
  final success;
  final message;

  ResultPage({required this.success, required this.message});

  Future<bool> _willPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                success ? Icons.done_rounded : Icons.error_rounded,
                size: 130,
                color: success ? Colors.green : Colors.red,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$message',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: Icon(
                      Icons.copy,
                      size: 20,
                    ),
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: message),
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton(
                child: Text("Go Back"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        title: 'Expense Management',
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
