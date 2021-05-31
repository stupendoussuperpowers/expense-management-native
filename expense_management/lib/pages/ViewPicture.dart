import 'package:flutter/material.dart';

class ViewPicture extends StatelessWidget {
  final imagePath;

  ViewPicture({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network('http://10.0.2.2:1234/images/$imagePath'),
        //child: imagePath,
      ),
    );
  }
}
