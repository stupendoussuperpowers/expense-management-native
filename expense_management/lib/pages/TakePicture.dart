import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'ConfirmScreen.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends StatefulWidget {
  final CameraDescription camera;
  final amount;
  final memo;
  final group;
  final recurring;

  const TakePicture({
    required this.camera,
    required this.amount,
    required this.memo,
    required this.group,
    required this.recurring,
  });

  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late Future<void> _initializeController;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    print("Hello -> ${widget.amount}");
    _initializeController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConfirmScreen(
                      imagePath: pickedFile.path,
                      memo: widget.memo,
                      amount: widget.amount,
                      group: widget.group,
                      recurring: widget.recurring,
                    ),
                  ),
                );
              }
            },
            icon: Icon(Icons.camera_roll),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            await _initializeController;

            final image = await _controller.takePicture();
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ConfirmScreen(
                  imagePath: image.path,
                  memo: widget.memo,
                  amount: widget.amount,
                  group: widget.group,
                  recurring: widget.recurring,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        label: const Icon(Icons.camera_alt),
      ),
    );
  }
}
