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
  String selectedGroup = '';
  String selectedType = '';
  String memo = '';
  int amount = 0;
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
        DropdownButton<String>(
          //  value: selectedGroup != '' ? selectedGroup : groupList[0].groupID,
          onChanged: (value) => setState(() {
            selectedGroup = value.toString();
          }),
          items: groups.map<DropdownMenuItem<String>>((x) {
            return DropdownMenuItem<String>(
              child: Text('${x.groupName}'),
              value: '${x.groupID}',
            );
          }).toList(),
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
          onPressed: () async {
            WidgetsFlutterBinding.ensureInitialized();
            final cameras = await availableCameras();
            final firstCamera = cameras.first;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TakePicture(
                  camera: firstCamera,
                  memo: memo,
                  amount: amount,
                  group: selectedGroup,
                ),
              ),
            );
          },
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
              //  addProof(),
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
                  amount: amount,
                  group: selectedGroup,
                ),
              ),
            );
          },
          child: Text(
            'Add Proof',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
