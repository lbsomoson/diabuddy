import 'dart:io';

import 'package:diabuddy/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImageUpload2Widget extends StatefulWidget {
  final Function(String path, File file)? callBack;
  const ImageUpload2Widget({this.callBack, super.key});

  @override
  State<ImageUpload2Widget> createState() => _ImageUpload2WidgetState();
}

class _ImageUpload2WidgetState extends State<ImageUpload2Widget> {
  File? selectedImage;
  String? path;

  Future _pickImageFromGallery(String id) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

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
      path = '/$id/uploads/$fileName';
    });
    widget.callBack!(path!, selectedImage!);
  }

  Future _pickImageFromCamera(String id) async {
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
      path = '/$id/uploads/$fileName';
    });
    print(path);
    widget.callBack!(path!, selectedImage!);
  }

  void _showDialog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500, maxWidth: 300),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Material(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          splashColor: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            _pickImageFromGallery(id);
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_size_select_actual_rounded,
                                  color: Color.fromRGBO(100, 204, 197, 1),
                                  size: 100,
                                ),
                                Text("Open file from gallery",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Material(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          splashColor: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            _pickImageFromCamera(id);
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_rounded,
                                  color: Color.fromRGBO(100, 204, 197, 1),
                                  size: 100,
                                ),
                                Text("Open camera",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User userId = context.read<UserAuthProvider>().user!;

    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
      onTap: () {
        // TODO: Open image from gallery, ask permission
        _showDialog(context, userId.uid);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
              border: Border.all(width: 2, color: Colors.grey[200]!)),
          child: selectedImage != null
              ? Image.file(
                  selectedImage!,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.add,
                    size: 75,
                    color: Colors.grey[300],
                  ),
                )),
    );
  }
}
