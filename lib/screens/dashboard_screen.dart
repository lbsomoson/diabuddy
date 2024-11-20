import 'dart:async';
import 'package:diabuddy/api/meal_api.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/dashboard_widgets.dart';
import 'package:diabuddy/widgets/semi_circle_progressbar.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FirebaseMealAPI firestore = FirebaseMealAPI();
  final double sizedBoxHeight = 15;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';
  late Timer _midnightTimer;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // firestore.uploadJsonDataToFirestore();
    loadDailySteps();
    startMidnightResetTimer();
  }

  @override
  void dispose() {
    _midnightTimer.cancel();
    super.dispose();
  }

  Future<void> loadDailySteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _steps = prefs.getString('daily_steps') ?? '0';
    });
  }

  Future<void> saveDailySteps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('daily_steps', _steps);
  }

  void startMidnightResetTimer() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);
    Duration timeUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(timeUntilMidnight, () {
      resetDailySteps();
      startMidnightResetTimer(); // restart timer for the next day
    });
  }

  void resetDailySteps() {
    setState(() {
      _steps = '0';
    });
    saveDailySteps();
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps.toString();
    });
    saveDailySteps();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<bool> _checkActivityRecognitionPermission() async {
    bool granted = await Permission.activityRecognition.isGranted;

    if (!granted) {
      granted = await Permission.activityRecognition.request() == PermissionStatus.granted;
    }

    return granted;
  }

  // Future<void> initPlatformState() async {
  //   bool granted = await _checkActivityRecognitionPermission();
  //   if (!granted) {}

  //   _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //   (await _pedestrianStatusStream.listen(onPedestrianStatusChanged))
  //       .onError(onPedestrianStatusError);

  //   _stepCountStream = Pedometer.stepCountStream;
  //   _stepCountStream.listen(onStepCount).onError(onStepCountError);

  //   if (!mounted) return;
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
                    TextWidget(text: "Hello $firstName!", style: 'bodyLarge'),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(text: "Health Index Score", style: 'titleSmall'),
                        TextWidget(text: "10.0", style: "bodyLarge")
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Divider(color: Colors.grey[400]),
                SizedBox(height: sizedBoxHeight),
                const SemiCircleProgressBar(title: "Title"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(child: DashboardWidget(header: "Glycemic Index", value: 99.0)),
                    SizedBox(width: sizedBoxHeight),
                    const Expanded(
                        child: DashboardWidget(header: "Diet Diversity Score", value: 7.5)),
                  ],
                ),
                SizedBox(height: sizedBoxHeight),
                const Row(
                  children: [
                    Expanded(child: DashboardWidget(header: "Calories", value: 2000)),
                    SizedBox(width: 10),
                    Expanded(
                        child: DashboardWidget(
                            header: "Carbohydrates", value: 1099, caloriesValue: 2000)),
                  ],
                ),
                SizedBox(height: sizedBoxHeight),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Activity Status",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: sizedBoxHeight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.directions_walk_rounded,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary,
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
                          Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.fire,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                (int.parse(_steps) / 25).toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 19, 98, 93),
                                  fontSize: 22,
                                ),
                              ),
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
                    ],
                  ),
                ),
                SizedBox(height: sizedBoxHeight),
                // InkWell(
                //   borderRadius: BorderRadius.circular(15),
                //   splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                //   onTap: () {},
                //   child: GestureDetector(
                //     onTap: () => Navigator.pushNamed(context, "/history"),
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 10.0,
                //         horizontal: 20,
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.grey[300]!,
                //           width: 2.0,
                //         ),
                //         borderRadius: BorderRadius.circular(15),
                //         color: Colors.transparent,
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const TextWidget(
                //             text: "View statistics",
                //             style: "bodyMedium",
                //           ),
                //           Icon(
                //             Icons.keyboard_arrow_right_rounded,
                //             color: Theme.of(context).colorScheme.primary,
                //             size: 30,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // InkWell(
                //   borderRadius: BorderRadius.circular(15),
                //   splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                //   onTap: () {},
                //   child: GestureDetector(
                //     onTap: () => Navigator.pushNamed(context, "/historyAll"),
                //     child: Container(
                //       padding: const EdgeInsets.symmetric(
                //         vertical: 10.0,
                //         horizontal: 20,
                //       ),
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.grey[300]!,
                //           width: 2.0,
                //         ),
                //         borderRadius: BorderRadius.circular(15),
                //         color: Colors.transparent,
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const TextWidget(
                //             text: "View history",
                //             style: "bodyMedium",
                //           ),
                //           Icon(
                //             Icons.keyboard_arrow_right_rounded,
                //             color: Theme.of(context).colorScheme.primary,
                //             size: 30,
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
