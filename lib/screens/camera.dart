import 'dart:io';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? selectedImage;
  String? path;
  String? userId;

  @override
  void initState() {
    super.initState();
    // use Future.delayed to ensure the context is fully initialized before accessing userId
    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user!.uid;
      _pickImageFromCamera(userId);
    });
  }

  Future _pickImageFromCamera(userId) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
    // get the file path from the File object
    String filePath = selectedImage!.path;
    // find the index of the last occurrence of "/"
    int lastIndex = filePath.lastIndexOf('/');

    // extract the substring starting from the position after the last occurrence of "/"
    String fileName = filePath.substring(lastIndex + 1);

    setState(() {
      path = '/$userId/uploads/$fileName';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add Meal"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                      border: Border.all(width: 2, color: Colors.grey[200]!)),
                  child: selectedImage != null
                      ? Image.file(
                          selectedImage!,
                          fit: BoxFit.fitHeight,
                        )
                      : Center(
                          child: Icon(
                            Icons.add,
                            size: 75,
                            color: Colors.grey[300],
                          ),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
