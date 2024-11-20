import 'dart:io';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/meal/meal_bloc.dart';
import 'package:diabuddy/utils/classes.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<String?> foodList = [];
  List<TextEditingController> controllers = [];

  List<Meal> mealsDetected = [];
  List<Meal> allMeals = [];

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
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted) {
    } else {
      print('Camera permission denied');
    }
  }

  Future loadModel() async {
    try {
      print("Attempting to load model...");
      _objectModel = await PytorchLite.loadObjectDetectionModel(
          "assets/models/best.torchscript", 8, 640, 640,
          labelPath: "assets/models/labels.txt",
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
        minimumScore: 0.5,
        iOUThreshold: 0.3);

    for (var element in objDetect) {
      final item = element?.className;
      // only add unique items
      if (!foodList.contains(item)) {
        foodList.add(element?.className?.trim());
        controllers.add(TextEditingController(text: element?.className?.trim()));
      }
    }

    for (var element in objDetect) {
      print({
        "score": element?.score,
        "className": element?.className,
        // "class": element?.classIndex,
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

    if (objDetect.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('No food detected!'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }

  Future _pickImageFromGallery(String id) async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

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

  Future _pickImageFromCamera(String id) async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
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
      foodList.add('');
      controllers.add(TextEditingController(text: ''));
    });
  }

  void _removeTextField(int index) {
    if (index < foodList.length && index < controllers.length) {
      setState(() {
        // remove the food item and its corresponding controller
        foodList.removeAt(index);
        controllers.removeAt(index);
      });
    }
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
                          child: _objectModel!.renderBoxesOnImage(selectedImage!, objDetect),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 25, 80),
                            child: Column(
                              children: [
                                foodList.isEmpty
                                    ? Container()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            allMeals.isEmpty
                                                ? Column(
                                                    children: [
                                                      const TextWidget(
                                                          text: "Food", style: 'bodyMedium'),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      ListView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          itemCount: foodList.length,
                                                          itemBuilder:
                                                              (BuildContext context, int index) {
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(8.0),
                                                              ),
                                                              child: ListTile(
                                                                dense: true,
                                                                title: TextField(
                                                                  controller: controllers[index],
                                                                  onChanged: (val) {
                                                                    setState(() {
                                                                      foodList[index] = val;
                                                                    });
                                                                  },
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                  decoration: InputDecoration(
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primary,
                                                                          width: 2.0),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    border: OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors.grey[200]!),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    labelStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium,
                                                                    hintStyle: Theme.of(context)
                                                                        .textTheme
                                                                        .labelMedium,
                                                                    contentPadding:
                                                                        const EdgeInsets.symmetric(
                                                                            vertical: 10,
                                                                            horizontal: 16),
                                                                  ),
                                                                ),
                                                                trailing: Row(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    IconButton(
                                                                      icon: Icon(Icons.delete,
                                                                          color: Theme.of(context)
                                                                              .primaryColor),
                                                                      onPressed: () =>
                                                                          _removeTextField(index),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }),
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
                                                                    text: "Add food",
                                                                    style: "body2"),
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
                                                              print("Button Clicked");
                                                              context
                                                                  .read<MealBloc>()
                                                                  .add(const LoadMeals());

                                                              for (var item in foodList) {
                                                                print(item);
                                                              }
                                                            }
                                                          },
                                                          label: "Submit",
                                                          style: 'filled'),
                                                      BlocListener<MealBloc, MealState>(
                                                          listener: (context, state) {
                                                            if (state is MealLoaded) {
                                                              // update the allMeals list when meals are loaded
                                                              setState(() {
                                                                allMeals = state.meals;
                                                              });
                                                              for (var f in foodList) {
                                                                classNames.forEach((k, v) {
                                                                  if (f == k) {
                                                                    var idx = allMeals.indexWhere(
                                                                        (meal) =>
                                                                            meal.mealName == v);
                                                                    print('idx: $idx');
                                                                    if (idx != -1) {
                                                                      mealsDetected
                                                                          .add(allMeals[idx]);
                                                                    }
                                                                    print('$k: $v');
                                                                  }
                                                                });
                                                              }
                                                              print('==== meals detected ====');
                                                              print(mealsDetected);

                                                              Meal accMeals = accumulateMealValues(
                                                                  mealsDetected);

                                                              print('==== meals accumulated ====');
                                                              print(accMeals);

                                                              print(
                                                                  '+++++ lenght: ${allMeals.length}');
                                                            } else if (state is MealNotFound) {
                                                              // show an error message if the medication was not found
                                                              final snackBar = SnackBar(
                                                                backgroundColor: Colors.red,
                                                                content:
                                                                    const Text('Meal not found!'),
                                                                action: SnackBarAction(
                                                                  label: 'Close',
                                                                  onPressed: () {},
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(snackBar);
                                                            } else if (state is MealError) {
                                                              // handle any errors here
                                                              final snackBar = SnackBar(
                                                                backgroundColor: Colors.red,
                                                                content: Text(state.message),
                                                                action: SnackBarAction(
                                                                  label: 'Close',
                                                                  onPressed: () {},
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(snackBar);
                                                            }
                                                          },
                                                          child: const SizedBox()),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      // const SizedBox(
                                                      //   height: 10,
                                                      // ),
                                                      // const Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment.spaceBetween,
                                                      //   children: [
                                                      //     Text("Food Group",
                                                      //         style: TextStyle(
                                                      //           fontSize: 18,
                                                      //           fontWeight: FontWeight.w700,
                                                      //           color: Color.fromRGBO(4, 54, 74, 1),
                                                      //           fontFamily: 'Roboto',
                                                      //         )),
                                                      //     TextWidget(
                                                      //         text: "Dec 22", style: "bodySmall")
                                                      //   ],
                                                      // ),
                                                      // const SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      // Divider(color: Colors.grey[400]),
                                                      // const SizedBox(
                                                      //   height: 5,
                                                      // ),
                                                      // Container(
                                                      //   padding: const EdgeInsets.symmetric(
                                                      //       horizontal: 15),
                                                      //   child: Column(
                                                      //     children: [
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Carbohydrates",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text:
                                                      //                   "${widget.meal.carbohydrate.toString()} g",
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Calories",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text:
                                                      //                   "${widget.meal.energyKcal.toString()} kCal",
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Glycemic Index",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.glycemicIndex
                                                      //                   .toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Diversity Score",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.diversityScore
                                                      //                   .toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Calcium",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.calcium
                                                      //                   .toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Fat",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text:
                                                      //                   widget.meal.fat.toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Iron",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text:
                                                      //                   widget.meal.iron.toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Phosphorus",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.phosphorus
                                                      //                   .toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Protein",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.protein
                                                      //                   .toString(),
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Niacin",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.niacin,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Cholesterol",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.cholesterol,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Phytochemical Index",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget
                                                      //                   .meal.phytochemicalIndex,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Potassium",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.potassium,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Retinol",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.retinol,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Riboflavin",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.riboflavin,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Thiamin",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.thiamin,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Total Dietary Fiber",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget
                                                      //                   .meal.totalDietaryFiber,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Total Sugar",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.totalSugar,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Vitamin C",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.vitaminC,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("Zinc",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.zinc,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Text("beta-carotene",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               )),
                                                      //           TextWidget(
                                                      //               text: widget.meal.betaCarotene,
                                                      //               style: "bodySmall")
                                                      //         ],
                                                      //       ),
                                                      //       Row(
                                                      //         mainAxisAlignment:
                                                      //             MainAxisAlignment.spaceBetween,
                                                      //         children: [
                                                      //           const Column(children: [
                                                      //             Text(
                                                      //               "Sodium",
                                                      //               style: TextStyle(
                                                      //                 fontSize: 16,
                                                      //                 fontWeight: FontWeight.w700,
                                                      //                 color: Color.fromRGBO(
                                                      //                     4, 54, 74, 1),
                                                      //                 fontFamily: 'Roboto',
                                                      //               ),
                                                      //               textAlign: TextAlign.start,
                                                      //             ),
                                                      //             Text("")
                                                      //           ]),
                                                      //           Column(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment.end,
                                                      //             children: [
                                                      //               for (String value
                                                      //                   in widget.meal.sodium ?? [])
                                                      //                 TextWidget(
                                                      //                   text: value,
                                                      //                   style: "bodySmall",
                                                      //                 ),
                                                      //             ],
                                                      //           ),
                                                      //         ],
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      // const SizedBox(
                                                      //   height: 20,
                                                      // )
                                                    ],
                                                  ),
                                          ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2.0,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              width: double.infinity,
                              child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  splashColor: Theme.of(context).colorScheme.secondary,
                                  onTap: () async {
                                    await _pickImageFromCamera(userId!);
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
                              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              width: double.infinity,
                              child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15.0),
                                  splashColor: Theme.of(context).colorScheme.secondary,
                                  onTap: () async {
                                    await _pickImageFromGallery(userId!);
                                  },
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Icon(
                                        Icons.photo_size_select_actual_rounded,
                                        color: Color.fromRGBO(100, 204, 197, 1),
                                        size: 100,
                                      ),
                                      Text("Open Gallery",
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
                          ]),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
