import 'dart:io';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/add_food_manually.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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
  List<String?> addedFood = [];
  String newFood = '';

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
      await _pickImageFromCamera(userId!);
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
    objDetect = await _objectModel!.getImagePrediction(
        await File(selectedImage!.path).readAsBytes(),
        minimumScore: 0.1,
        iOUThreshold: 0.3);

    for (var element in objDetect) {
      addedFood.add(element?.className);
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

    // trigger setState to update ui
    setState(() {});
  }

  // Future _pickImageFromGallery(String id) async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   if (returnedImage == null) return;

  //   setState(() {
  //     selectedImage = File(returnedImage.path);
  //   });

  //   String filePath = selectedImage!.path;
  //   int lastIndex = filePath.lastIndexOf('/');
  //   String fileName = filePath.substring(lastIndex + 1);

  //   setState(() {
  //     path = '/$id/uploads/$fileName';
  //   });

  //   print('selectedImage: $path');
  //   detectObjects();
  // }

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
    detectObjects();
  }

  void _addNewTextField() {
    setState(() {
      addedFood.add(newFood);
      newFood = '';
    });
    print(addedFood);
  }

  void _removeTextField(int index) {
    setState(() {
      addedFood.removeAt(index);
    });
    print(addedFood);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add Meal"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _objectModel != null
                  ? Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 0.8,
                          child: _objectModel!
                              .renderBoxesOnImage(selectedImage!, objDetect),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 25, 80),
                            child: Column(
                              children: [
                                addedFood.isEmpty
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const TextWidget(
                                              text: "Detected Food",
                                              style: 'bodyMedium'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: addedFood.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: ListTile(
                                                    dense: true,
                                                    title: TextFieldWidget(
                                                      callback: (String val) {
                                                        setState(() {
                                                          newFood = val;
                                                        });
                                                      },
                                                      initialValue:
                                                          addedFood[index] ??
                                                              '',
                                                      hintText: '',
                                                      type: 'String',
                                                    ),
                                                    trailing: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.delete,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                          onPressed: () =>
                                                              _removeTextField(
                                                                  index),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () => _addNewTextField(),
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            size: 22,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text2Widget(
                                              text: "Add food", style: "body2"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ButtonWidget(
                                    callback: () {
                                      if (_formKey.currentState!.validate()) {
                                        print(addedFood);
                                      }
                                    },
                                    label: "Submit",
                                    style: 'filled')
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            width: double.infinity,
                            child: Material(
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                splashColor:
                                    Theme.of(context).colorScheme.secondary,
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
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
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
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            width: double.infinity,
                            child: Material(
                              borderRadius: BorderRadius.circular(15.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                splashColor:
                                    Theme.of(context).colorScheme.secondary,
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
                                    ),
                                    Text("Add food manually",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        )),
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
            ],
          ),
        ),
      ),
    );
  }
}
