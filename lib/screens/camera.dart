import 'dart:io';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/meal_provider.dart';
import 'package:diabuddy/screens/meal_details.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _formKey = GlobalKey<FormState>();
  File? selectedImage;
  String? path;
  String? userId;
  bool imageSelected = false;
  late List results = [];
  List? _recognitions;
  late String mealName;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user!.uid;
    });
    loadModel();
  }

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      await _pickImageFromGallery(userId!);
    } else {
      print('Camera permission denied');
    }
  }

  // Future loadModel() async {
  //   print("loading model====================");
  //   Tflite.close(); // close any previously loaded models
  //   String res;
  //   res = (await Tflite.loadModel(
  //     model: 'assets/sp2_metadata_v4.tflite',
  //   ))!;
  //   print("Model loading status: $res");
  // }

  Future loadModel() async {
    try {
      Tflite.close(); // close any previously loaded models
      print("Attempting to load model...");
      String? res = await Tflite.loadModel(
        model: 'assets/sp2_metadata_v4.tflite',
      );
      if (res != null) {
        print("Model loaded successfully: $res");
      } else {
        print("Model loaded with null response.");
      }
    } catch (e) {
      print("Exception during model load: $e");
    }
  }

  Future<void> getImageAndPredict(File image) async {
    List? recognitions = await predictImage(image);
    setState(() {
      _recognitions = recognitions;
    });

    print("Recognitions: $_recognitions");
  }

  Future<List?> predictImage(File image) async {
    try {
      img.Image imageInput = img.decodeImage(image.readAsBytesSync())!;
      img.Image resizedImage =
          img.copyResize(imageInput, width: 320, height: 320);

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_image.png');
      tempFile.writeAsBytesSync(img.encodePng(resizedImage));

      var recognitions = await Tflite.detectObjectOnImage(
        path: tempFile.path,
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,
        numResultsPerClass: 10,
        blockSize: 32,
        numBoxesPerBlock: 5,
        asynch: true,
      );

      // Process tensors
      // List<List<dynamic>> tensor0 = recognitions?[0]["locations"];
      // List<List<List<dynamic>>> tensor1 = recognitions?[1]["locations"];
      // List<dynamic> tensor2 = recognitions?[2]["locations"];
      // List<List<dynamic>> tensor3 = recognitions?[3]["locations"];

      // Process each tensor accordingly
      // For example, you might print or process each tensor here

      print(recognitions);

      return recognitions;
    } catch (e) {
      print("Error during image prediction: $e");
      return null;
    }
  }

  Future _pickImageFromGallery(String id) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });

    getImageAndPredict(selectedImage!);

    // get the file path from the File object
    String filePath = selectedImage!.path;
    // find the index of the last occurrence of "/"
    int lastIndex = filePath.lastIndexOf('/');

    // extract the substring starting from the position after the last occurrence of "/"
    String fileName = filePath.substring(lastIndex + 1);

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
                            // Column(
                            //   children: results
                            //       .map((result) => Text(result))
                            //       .toList(),
                            // )
                          ],
                        )
                      : Center(child: Container())),
              // const TextWidget(
              //   text: "Meal Name",
              //   style: 'bodyLarge',
              // ),
              ButtonWidget(
                  block: true,
                  callback: () {
                    checkAndRequestPermissions();
                  },
                  label: "Capture Food",
                  style: 'filled'),
              Form(
                key: _formKey,
                child: TextFieldWidget(
                    callback: (String val) {
                      mealName = val;
                    },
                    hintText: "Meal Name",
                    label: "Meal Name",
                    type: 'String'),
              ),
              ButtonWidget(
                block: true,
                callback: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic>? mealMap = await context
                        .read<MealProvider>()
                        .getMealInfo(mealName);

                    if (mealMap != null && context.mounted) {
                      Meal meal = Meal.fromJson(mealMap);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MealDetailsScreen(meal: meal);
                      }));
                    }
                  }
                },
                label: "Find Food",
                style: 'filled',
              )
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