import 'dart:async';
import 'package:diabuddy/api/meal_api.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/screens/advice.dart';
import 'package:diabuddy/widgets/dashboard_widgets.dart';
import 'package:diabuddy/widgets/semi_circle_progressbar.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:health/health.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// ignore: constant_identifier_names
enum AppState { DATA_NOT_FETCHED, FETCHING_DATA, DATA_READY, NO_DATA, AUTH_NOT_GRANTED }

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseMealAPI firestore = FirebaseMealAPI();
  final double sizedBoxHeight = 15;

  @override
  void initState() {
    super.initState();
    // firestore.uploadJsonDataToFirestore();
    // await Permission.activityRecognition.request();
    // await Permission.location.request();
  }

  Future<void> loadDailySteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _steps = prefs.getString('daily_steps') ?? '0';
    });
  }

  Future<void> saveDailySteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('daily_steps', _steps);
  }

  // Fetch steps from the health plugin and show them in the app.
  // Future<void> fetchStepData() async {
  //   int? steps;

  //   // get steps for today (i.e., since midnight)
  //   final now = DateTime.now();
  //   final midnight = DateTime(now.year, now.month, now.day);

  //   bool stepsPermission = await Health().hasPermissions([HealthDataType.STEPS]) ?? false;
  //   if (!stepsPermission) {
  //     stepsPermission = await Health().requestAuthorization([HealthDataType.STEPS]);
  //   }

  //   if (stepsPermission) {
  //     try {
  //       steps = await Health().getTotalStepsInInterval(midnight, now,
  //           includeManualEntry: !recordingMethodsToFilter.contains(RecordingMethod.manual));
  //     } catch (error) {
  //       debugPrint("Exception in getTotalStepsInInterval: $error");
  //     }

  //     debugPrint('Total number of steps: $steps');

  //     setState(() {
  //       _nofSteps = (steps == null) ? 0 : steps;
  //       _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
  //     });
  //   } else {
  //     debugPrint("Authorization not granted - error in authorization");
  //     setState(() => _state = AppState.DATA_NOT_FETCHED);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user;
    List<String> nameParts = user!.displayName!.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, "/cameraScreen");
      //   },
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.camera_alt),
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "Hello, $firstName!", style: 'bodyLarge'),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const AdviceScreen(isBmiNormal: true, isNormalPhysicalActivity: true);
                          }));
                        },
                        icon: Icon(
                          Icons.lightbulb,
                          color: Theme.of(context).primaryColor,
                        ))
                    // const Column(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     TextWidget(text: "Health Index Score", style: 'titleSmall'),
                    //     TextWidget(text: "10.0", style: "bodyLarge")
                    //   ],
                    // )
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 10),
                Text(
                  "2000 kCal",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Text(
                  "Daily Calorie Intake",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(4, 54, 74, 1),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(35),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const CircleProgressIndicator(
                    title: "Title",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 74,
                          stepSize: 10,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Colors.grey[100],
                          padding: 0,
                          width: 80,
                          height: 80,
                          selectedStepSize: 5,
                          unselectedStepSize: 5,
                          roundedCap: (_, __) => true,
                          child: const Icon(FontAwesomeIcons.shoePrints),
                        ),
                        // Text(_steps,
                        //     style: const TextStyle(
                        //       color: Color.fromARGB(255, 19, 98, 93),
                        //       fontSize: 22,
                        //     )),
                        const Text(
                          "steps",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 74,
                          stepSize: 10,
                          selectedColor: Theme.of(context).primaryColor,
                          unselectedColor: Colors.grey[100],
                          padding: 0,
                          width: 80,
                          height: 80,
                          selectedStepSize: 5,
                          unselectedStepSize: 5,
                          roundedCap: (_, __) => true,
                          child: const Icon(
                            FontAwesomeIcons.fire,
                          ),
                        ),
                        // Text(
                        //   (int.parse(_steps) / 25).toString(),
                        //   style: const TextStyle(
                        //     color: Color.fromARGB(255, 19, 98, 93),
                        //     fontSize: 22,
                        //   ),
                        // ),
                        const Text(
                          "kCal burned",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const Expanded(child: DashboardWidget(header: "Glycemic Index", value: 99.0)),
                    SizedBox(width: sizedBoxHeight),
                    const Expanded(child: DashboardWidget(header: "Diet Diversity Score", value: 7.5)),
                  ],
                ),
                SizedBox(height: sizedBoxHeight),
                const Row(
                  children: [
                    Expanded(child: DashboardWidget(header: "Calories", value: 2000)),
                    SizedBox(width: 10),
                    Expanded(child: DashboardWidget(header: "Carbohydrates", value: 1099, caloriesValue: 2000)),
                  ],
                ),
                SizedBox(height: sizedBoxHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
