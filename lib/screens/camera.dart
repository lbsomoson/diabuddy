import 'dart:io';
import 'dart:isolate';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? selectedImage;
  String? path;
  String? userId;
  bool imageSelected = false;
  late List results = [];

  @override
  void initState() {
    super.initState();
    // use Future.delayed to ensure the context is fully initialized before accessing userId
    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user!.uid;
    });
    loadModel();
  }

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      // permission granted, proceed with Isolate spawning
      await _pickImageFromGallery(userId!);
      await useIsolate(selectedImage!);
    } else {
      // permission denied, handle accordingly
      print('Camera permission denied');
    }
  }

  Future loadModel() async {
    print("loading model====================");
    Tflite.close(); // close any previously loaded models
    String res;
    res = (await Tflite.loadModel(
      model: 'assets/sp2_metadata_v4.tflite',
    ))!;
    print("Model loading status: $res");
  }

  Future imageClassification(List<dynamic> args) async {
    print("in image classifications====================");
    SendPort resultPort = args[0];
    var recognitions = await Tflite.runModelOnImage(
        path: args[1].path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);

    print(recognitions);
    setState(() {
      results = recognitions!;
    });

    Isolate.exit(resultPort, recognitions!);
  }

  useIsolate(File image) async {
    final ReceivePort receivePort = ReceivePort();

    try {
      await Isolate.spawn(imageClassification, [receivePort.sendPort, image]);
    } on Object {
      print("Isolate failed to spawn");
      receivePort.close();
    }

    final response = await receivePort.first;
    print('Result:::::: $response');
  }

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

    print("calling useIsolate");
    useIsolate(selectedImage!);

    setState(() {
      path = '/$id/uploads/$fileName';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                      border: Border.all(width: 2, color: Colors.grey[200]!)),
                  child: selectedImage != null
                      ? Column(
                          children: [
                            Image.file(
                              selectedImage!,
                              fit: BoxFit.fitHeight,
                            ),
                            Column(
                              children: results
                                  .map((result) => Text(result))
                                  .toList(),
                            )
                          ],
                        )
                      : Center(child: Container())),
              const TextWidget(
                text: "Meal Name",
                style: 'bodyLarge',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // Future _pickImageFromCamera(userId) async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnedImage == null) return;
  //   setState(() {
  //     selectedImage = File(returnedImage.path);
  //   });
  //   // get the file path from the File object
  //   String filePath = selectedImage!.path;
  //   // find the index of the last occurrence of "/"
  //   int lastIndex = filePath.lastIndexOf('/');

  //   // extract the substring starting from the position after the last occurrence of "/"
  //   String fileName = filePath.substring(lastIndex + 1);
  //   print("calling useIsolate");
  //   useIsolate(selectedImage!);

  //   setState(() {
  //     path = '/$userId/uploads/$fileName';
  //   });
  // }