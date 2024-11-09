import 'dart:io';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/add_food_manually.dart';
import 'package:diabuddy/screens/detected_page.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late String mealName;
  String? userId;
  File? selectedImage;
  String? path;
  bool imageSelected = false;
  ModelObjectDetection? _objectModel;
  List<ResultObjectDetection?> objDetect = [];

  // classnames of the detected objects
  List<String> detectedObjectsList = [];

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

    if (context.mounted) return;

    // get object predictions
    objDetect = await _objectModel!.getImagePrediction(
        await File(selectedImage!.path).readAsBytes(),
        minimumScore: 0.1,
        iOUThreshold: 0.3);

    // print detected object details
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

    // update the state with the modified image
    setState(() {
      detectedObjectsList =
          objDetect.map((obj) => obj!.className.toString().trim()).toList();
      detectedObjectsList = detectedObjectsList.toSet().toList();
    });

    // navigate to DetectedPage with the modified image
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DetectedPage(
          detectedObjectsList: detectedObjectsList,
          imgBoundingBox:
              _objectModel!.renderBoxesOnImage(selectedImage!, objDetect),
        );
      }));
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
                          Text("Open Camera",
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
