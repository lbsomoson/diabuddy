import 'dart:io';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/add_food_manually.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final _formKey = GlobalKey<FormState>();
  late String mealName;
  String? userId;
  File? selectedImage;
  String? path;
  bool imageSelected = false;
  ModelObjectDetection? _objectModel;
  List<ResultObjectDetection?> objDetect = [];
  // late List results = [];
  // List _recognitions = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user?.uid;
      if (userId == null) {
        print("User ID is null");
      } else {
        loadModel();
      }
    });
  }

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted) {
      await _pickImageFromGallery(userId!);
    } else {
      print('Camera permission denied');
    }
  }

  Future loadModel() async {
    try {
      print("Attempting to load model...");
      _objectModel = await PytorchLite.loadObjectDetectionModel(
          "assets/models/yolov5s.torchscript", 80, 640, 640,
          labelPath: "assets/models/labels_coco.txt",
          objectDetectionModelType: ObjectDetectionModelType.yolov5);

      if (_objectModel != null) {
        print("Model loaded successfully: $_objectModel");
      } else {
        print("Model loaded with null response.");
      }
    } catch (e) {
      print("Exception during model load: $e");
    }
  }

  detectObjects() async {
    print("detecting objects ------");
    objDetect = await _objectModel!.getImagePrediction(
        await File(selectedImage!.path).readAsBytes(),
        minimumScore: 0.1,
        iOUThreshold: 0.3);

    for (var element in objDetect) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    }
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future _pickImageFromGallery(String id) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });

    String filePath = selectedImage!.path;
    int lastIndex = filePath.lastIndexOf('/');
    String fileName = filePath.substring(lastIndex + 1);

    setState(() {
      path = '/$id/uploads/$fileName';
    });

    print('selectedImage: $path');
    detectObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add Meal"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // selectedImage != null
                //     ? Container(
                //         padding: const EdgeInsets.symmetric(vertical: 50),
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: Colors.grey[100],
                //             border:
                //                 Border.all(width: 2, color: Colors.grey[200]!)),
                //         child: Column(
                //           children: [
                //             Image.file(
                //               selectedImage!,
                //               fit: BoxFit.fitHeight,
                //             ),
                //           ],
                //         ))
                //     : Container(),
                // ButtonWidget(
                //   block: true,
                //   callback: () {
                //     checkAndRequestPermissions();
                //   },
                //   label: "Open Camera",
                //   style: 'filled',
                // ),
                // Form(
                //   key: _formKey,
                //   child: TextFieldWidget(
                //     callback: (String val) {
                //       mealName = val;
                //     },
                //     hintText: "Meal Name",
                //     label: "Meal Name",
                //     type: 'String',
                //   ),
                // ),
                // ButtonWidget(
                //   block: true,
                //   callback: () async {
                //     if (_formKey.currentState!.validate()) {
                //       Map<String, dynamic>? mealMap = await context
                //           .read<MealProvider>()
                //           .getMealInfo(mealName);

                //       if (mealMap != null && context.mounted) {
                //         Meal meal = Meal.fromJson(mealMap);
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) {
                //           return MealDetailsScreen(meal: meal);
                //         }));
                //       } else {
                //         print(
                //             "Meal information is null or context is not mounted");
                //       }
                //     }
                //   },
                //   label: "Add Food Manually",
                //   style: 'filled',
                // )
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  width: double.infinity,
                  child: Material(
                    borderRadius: BorderRadius.circular(15.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      splashColor: Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        checkAndRequestPermissions();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Color.fromRGBO(100, 204, 197, 1),
                            size: 100,
                          ),
                          Text("Buksan ang camera",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(100, 204, 197, 1),
                              )),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2.0,
                    ),
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  width: double.infinity,
                  child: Material(
                    borderRadius: BorderRadius.circular(15.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.0),
                      splashColor: Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AddFoodManually();
                        }));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.search_rounded,
                            color: Color.fromRGBO(100, 204, 197, 1),
                            size: 100,
                          ), // icon
                          Text("Add food manually",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(100, 204, 197, 1),
                              )), // text
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
