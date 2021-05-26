import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  String selectedGroup = 'Group A';
  String selectedType = '';

  Widget selectType() {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        selectType(),
      ],
    );
  }
}
