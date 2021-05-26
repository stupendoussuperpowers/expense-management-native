import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class GroupNetPage extends StatelessWidget {
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

  Widget transactionHistory() {
    return Container(
      height: 400,
      child: Expanded(
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Dramatics Club'),
              subtitle: Text(
                'Rs. 450',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group A'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          netCost(460),
          transactionHistory(),
        ],
      ),
    );
  }
}
