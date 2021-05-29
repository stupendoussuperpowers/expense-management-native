import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  // Testing git and github
  String selectedGroup = 'Group A';
  String selectedType = '';
  String memo = '';
  int amount = 0;

  Widget selectType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Type',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  value: 'Credit',
                  groupValue: selectedType,
                  onChanged: (value) => setState(
                    () {
                      selectedType = value.toString();
                    },
                  ),
                ),
                Text('Credit')
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Debit',
                  groupValue: selectedType,
                  onChanged: (value) => setState(
                    () {
                      selectedType = value.toString();
                    },
                  ),
                ),
                Text('Debit')
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget selectGroup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Group',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        DropdownButton(
          value: selectedGroup,
          onChanged: (value) => setState(() {
            selectedGroup = value.toString();
          }),
          items: [
            DropdownMenuItem(child: Text('Group A'), value: 'Group A'),
            DropdownMenuItem(child: Text('Group B'), value: 'Group B'),
          ],
        ),
      ],
    );
  }

  Widget addMemo() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Add Memo',
      ),
      onChanged: (value) => setState(() {
        memo = value;
      }),
    );
  }

  Widget addAmount() {
    return Column(
      children: [
        Text(
          'Enter Amount',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Container(
          width: 200,
          child: TextField(
            decoration: InputDecoration(prefix: Text('Rs.')),
            onChanged: (value) => setState(() {
              amount = int.parse(value);
            }),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 30,
              color: selectedType == 'Credit' ? Colors.green : Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget addProof() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Attach Receipt',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.image),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addAmount(),
              selectGroup(),
              selectType(),
              addMemo(),
              addProof(),
            ],
          ),
        ),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () => {},
          child: Text(
            'Add Transaction',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
