import 'package:camera/camera.dart';
import 'package:expense_management/pages/TakePicture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTransaction extends StatefulWidget {
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class Group {
  final groupName;
  final groupID;

  Group({required this.groupName, required this.groupID});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(groupName: json['groupName'], groupID: json['groupID']);
  }
}

class _AddTransactionState extends State<AddTransaction> {
  // Testing git and github
  String selectedGroup = 'select';
  String selectedType = 'Credit';
  String memo = '';
  int amount = 0;
  bool recurring = false;
  List<Group> groups = [];

  _AddTransactionState() {
    getGroups().then(
      (value) => setState(
        () {
          groups = value;
        },
      ),
    );
  }

  Future<List<Group>> getGroups() async {
    final a = await http.get(Uri.parse(
        "http://10.0.2.2:1234/api/userGroups/f9Lta3B8BniVB9zSP1iuG4"));

    return parseGroup(a.body);
  }

  List<Group> parseGroup(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);

    return parsed["body"].map<Group>((json) => Group.fromJson(json)).toList();
  }

  Future<void> addTransaction() async {
    final a = await http.post(
      Uri.parse('http://10.0.2.2:1234/api/addTransaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user": "f9Lta3B8BniVB9zSP1iuG4",
        "groupID": selectedGroup,
        "amount": amount * (selectedType == 'Credit' ? 1 : -1),
        "memo": memo,
      }),
    );

    var b = jsonDecode(a.body)["success"];

    print(b);
    if (b) {
      print("Added!");
    } else {
      print("Not Added :(");
    }
  }

  Widget selectType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Type',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                Radio(
                  activeColor: Colors.white,
                  value: 'Credit',
                  groupValue: selectedType,
                  onChanged: (value) => setState(
                    () {
                      selectedType = value.toString();
                    },
                  ),
                ),
                Text(
                  'Credit',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Radio(
                  activeColor: Colors.white,
                  value: 'Debit',
                  groupValue: selectedType,
                  onChanged: (value) => setState(
                    () {
                      selectedType = value.toString();
                    },
                  ),
                ),
                Text(
                  'Debit',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
        Text('Credit'),
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
    );
  }

  Widget selectGroup() {
    var items = groups.map<DropdownMenuItem<String>>((x) {
      return DropdownMenuItem<String>(
        child: Text(
          '${x.groupName}',
          style: TextStyle(),
        ),
        value: '${x.groupID}',
      );
    }).toList();

    items.add(
      DropdownMenuItem<String>(
        child: Text('Select'),
        value: 'select',
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Group',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        DropdownButton<String>(
          value: selectedGroup,
          focusColor: Colors.white,
          onChanged: (value) => setState(() {
            selectedGroup = value.toString();
          }),
          items: items,
        ),
      ],
    );
  }

  Widget addMemo() {
    return TextField(
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Add Memo',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
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
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        Container(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              prefix: Text(
                'Rs.',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: (value) => setState(() {
              amount = int.parse(value);
            }),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 30,
              color:
                  selectedType == 'Credit' ? Colors.greenAccent : Colors.amber,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget recurringBox() {
    return Row(
      children: [
        Text(
          'Recurring?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        Checkbox(
          value: recurring,
          onChanged: (value) {
            setState(() {
              recurring = !recurring;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
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
                  recurringBox(),
                  addMemo(),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
              ),
              onPressed: () async {
                WidgetsFlutterBinding.ensureInitialized();
                final cameras = await availableCameras();
                final firstCamera = cameras.first;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePicture(
                      camera: firstCamera,
                      memo: memo,
                      amount: amount * (selectedType == 'Credit' ? 1 : -1),
                      group: selectedGroup,
                      recurring: recurring,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.arrow_right_alt),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
