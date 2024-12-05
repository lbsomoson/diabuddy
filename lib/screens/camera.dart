import 'dart:io';
import 'dart:typed_data';
import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record_provider.dart';
import 'package:diabuddy/provider/meal_intake_provider.dart';
import 'package:diabuddy/provider/meal_provider.dart';
import 'package:diabuddy/screens/meal_details.dart';
import 'package:diabuddy/utils/classes.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/dropdown.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
  ModelObjectDetection? _objectModel;
  List<ResultObjectDetection?> objDetect = [];
  bool isModelDoneAnalyzing = false;

  List<String?> foodList = [];
  List<TextEditingController> controllers = [];

  List<Meal> mealsDetected = [];
  List<Meal> allMeals = [];

  Meal accMeal = Meal(
      mealId: "",
      mealName: "",
      foodCode: "",
      calcium: 0.0,
      carbohydrate: 0.0,
      diversityScore: 0.0,
      energyKcal: 0.0,
      fat: 0.0,
      glycemicIndex: 0.0,
      iron: 0.0,
      phosphorus: 0.0,
      protein: 0.0,
      healthyEatingIndex: 0.0,
      niacin: 0.0,
      cholesterol: 0.0,
      phytochemicalIndex: 0.0,
      potassium: 0.0,
      retinol: 0.0,
      riboflavin: 0.0,
      sodium: [0.0, 0.0],
      thiamin: 0.0,
      totalDietaryFiber: 0.0,
      totalSugar: 0.0,
      vitaminC: 0.0,
      zinc: 0.0,
      betaCarotene: 0.0,
      heiClassification: "");
  MealIntake mealIntake = MealIntake(
      userId: '',
      foodIds: [],
      imageBytes: Uint8List(0),
      timestamp: null,
      mealTime: "",
      accMeals: Meal(
          mealId: "",
          mealName: "",
          foodCode: "",
          calcium: 0.0,
          carbohydrate: 0.0,
          diversityScore: 0.0,
          energyKcal: 0.0,
          fat: 0.0,
          glycemicIndex: 0.0,
          iron: 0.0,
          phosphorus: 0.0,
          protein: 0.0,
          healthyEatingIndex: 0.0,
          niacin: 0.0,
          cholesterol: 0.0,
          phytochemicalIndex: 0.0,
          potassium: 0.0,
          retinol: 0.0,
          riboflavin: 0.0,
          sodium: [0.0, 0.0],
          thiamin: 0.0,
          totalDietaryFiber: 0.0,
          totalSugar: 0.0,
          vitaminC: 0.0,
          zinc: 0.0,
          betaCarotene: 0.0,
          heiClassification: ""));

  final DateTime _currentDate = DateTime.now();

  // define time ranges for each meal period
  final breakfastStart = const TimeOfDay(hour: 6, minute: 0); // 6:00 AM
  final breakfastEnd = const TimeOfDay(hour: 10, minute: 0); // 10:00 AM

  final lunchStart = const TimeOfDay(hour: 12, minute: 0); // 12:00 PM
  final lunchEnd = const TimeOfDay(hour: 14, minute: 0); // 2:00 PM

  final dinnerStart = const TimeOfDay(hour: 18, minute: 0); // 6:00 PM
  final dinnerEnd = const TimeOfDay(hour: 21, minute: 0); // 9:00 PM

  @override
  void dispose() {
    super.dispose();

    for (var cont in controllers) {
      cont.dispose();
    }
  }

  String getCurrentMealTime() {
    // get the current time of day
    TimeOfDay now = TimeOfDay.now();

    // check the time range and return the corresponding meal time
    if (_isTimeInRange(now, breakfastStart, breakfastEnd)) {
      return "Breakfast";
    } else if (_isTimeInRange(now, lunchStart, lunchEnd)) {
      return "Lunch";
    } else if (_isTimeInRange(now, dinnerStart, dinnerEnd)) {
      return "Dinner";
    } else {
      return "Snack"; // any other time is considered a snack time
    }
  }

// helper function to check if a time is within a specific range
  bool _isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final currentMinutes = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return currentMinutes >= startMinutes && currentMinutes < endMinutes;
  }

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
    _loadAllMeals();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted) {
    } else {
      print('Camera permission denied');
    }
  }

  // Load the items asynchronously
  Future<void> _loadAllMeals() async {
    final meals = await context.read<MealProvider>().getMeals();
    setState(() {
      allMeals = meals;
    });
  }

  Future loadModel() async {
    try {
      print("Attempting to load model...");
      _objectModel = await PytorchLite.loadObjectDetectionModel("assets/models/best.torchscript", 8, 640, 640,
          labelPath: "assets/models/labels.txt", objectDetectionModelType: ObjectDetectionModelType.yolov5);

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
    objDetect = await _objectModel!
        .getImagePrediction(await File(selectedImage!.path).readAsBytes(), minimumScore: 0.5, iOUThreshold: 0.3);

    for (var element in objDetect) {
      final item = element?.className;
      // only add unique items
      if (!foodList.contains(item)) {
        foodList.add(element?.className?.trim());
        controllers.add(TextEditingController(text: element?.className?.trim()));
      }
    }

    isModelDoneAnalyzing = true;

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
    // Convert image to bytes
    final Uint8List bytes = await returnedImage.readAsBytes();
    mealIntake.imageBytes = bytes;

    setState(() {
      selectedImage = File(returnedImage.path);
    });

    String filePath = selectedImage!.path;
    int lastIndex = filePath.lastIndexOf('/');
    String fileName = filePath.substring(lastIndex + 1);

    setState(() {
      path = '/$id/uploads/$fileName';
    });

    detectObjects();
  }

  Future _pickImageFromCamera(String id) async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    // Convert image to bytes
    final Uint8List bytes = await returnedImage.readAsBytes();
    mealIntake.imageBytes = bytes;

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
    detectObjects();
  }

  void _addNewDropdown() {
    setState(() {
      foodList.add('');
      controllers.add(TextEditingController(text: ''));
    });
  }

  void _removeDropdown(int index) {
    if (index < foodList.length) {
      setState(() {
        foodList.removeAt(index);
        controllers.removeAt(index);
      });
    }
  }

  void _submitButtonClicked() {
    if (_formKey.currentState!.validate()) {
      try {
        // Process the meals
        mealsDetected.clear();
        for (var f in foodList) {
          classNames.forEach((k, v) {
            if (f == k) {
              var idx = allMeals.indexWhere((meal) => meal.mealName == v);
              if (idx != -1) {
                // If it exists in the list of all meals, add
                mealsDetected.add(allMeals[idx]);
                mealIntake.foodIds.add(allMeals[idx].mealId!);
              }
            }
          });
        }

        // Accumulate meal values
        accMeal = accumulateMealValues(mealsDetected);

        // Update meal intake
        mealIntake
          ..userId = userId!
          ..mealTime = getCurrentMealTime()
          ..timestamp = _currentDate
          ..accMeals = accMeal;

        // Create or update daily health record
        DailyHealthRecord record = DailyHealthRecord(
          recordId: "",
          userId: userId,
          date: mealIntake.timestamp!,
          healthyEatingIndex: accMeal.healthyEatingIndex!,
          glycemicIndex: accMeal.glycemicIndex!,
          carbohydrates: accMeal.carbohydrate!,
          energyKcal: accMeal.energyKcal!,
          diversityScore: accMeal.diversityScore!,
          stepsCount: 0.0,
        );

        context.read<MealIntakeProvider>().addMealIntake(mealIntake);
        context.read<DailyHealthRecordProvider>().updateRecord(record);

        // Navigate to the Meal Details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailsScreen(mealIntake: mealIntake),
          ),
        );
      } catch (e) {
        // Handle errors
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error: ${e.toString()}'),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void retakePhotoButtonClicked() {
    setState(() {
      mealsDetected.clear();
      _objectModel = null;
      objDetect = [];
      selectedImage = null;
      path = null;
      foodList = [];
    });
    controllers.clear();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        isModelDoneAnalyzing
                            ? Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 80),
                                  child: Column(
                                    children: [
                                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Column(
                                          children: [
                                            const Align(
                                                alignment: Alignment.topLeft,
                                                child: TextWidget(text: "Food", style: 'bodyMedium')),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: foodList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: ListTile(
                                                      dense: true,
                                                      title: FoodDropdown(
                                                        value: foodList[index]!,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            foodList[index] = newValue;
                                                          });
                                                        },
                                                      ),
                                                      trailing: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(Icons.delete,
                                                                color: Theme.of(context).primaryColor),
                                                            onPressed: () => _removeDropdown(index),
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
                                                onTap: () => _addNewDropdown(),
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
                                                        color: Theme.of(context).colorScheme.primary,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Text2Widget(text: "Add food", style: "body2"),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            ButtonWidget(
                                                callback: () {
                                                  _submitButtonClicked();
                                                },
                                                label: "Submit",
                                                style: 'filled'),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ButtonWidget(
                                            callback: () {
                                              retakePhotoButtonClicked();
                                            },
                                            label: "Retake Photo",
                                            style: 'outlined'),
                                      ]),
                                    ],
                                  ),
                                ),
                              )
                            : const Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                CircularProgressIndicator()
                              ]),
                      ],
                    )
                  : ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 1.2,
                      ),
                      child: Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
