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
  // Obtain shared preferences.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _stepFuture;

  final double sizedBoxHeight = 15;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  int _initialStepCount = 0;
  int _dailySteps = 0;

  @override
  void initState() {
    super.initState();
    _stepFuture = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('steps') ?? 0;
    });

    firestore.uploadJsonDataToFirestore();
    initPlatformState();
    _resetDailyStepsAtMidnight();
  }

  void onStepCount(StepCount event) async {
    print(event);
    setState(() {
      if (_initialStepCount == 0) {
        _initialStepCount = event.steps;
      }
      _dailySteps = event.steps - _initialStepCount;
      _steps = _dailySteps.toString();
    });
    final SharedPreferences prefs = await _prefs;
    final int steps = (prefs.getInt('steps') ?? 0) + 1;

    setState(() {
      _stepFuture = prefs.setInt('steps', steps).then((bool success) {
        return steps;
      });
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
    print(_status);
    if (_status == "stopped") {}
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available on this device';
    });
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available on this device';
    });
  }

  void initPlatformState() async {
    // Check and request activity recognition permission
    PermissionStatus status = await Permission.activityRecognition.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.activityRecognition.request();
      if (status != PermissionStatus.granted) {
        print('Activity Recognition permission not granted');
        setState(() {
          _steps = 'Permission not granted';
          _status = 'Permission not granted';
        });
        return;
      }
    }

    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void _resetDailyStepsAtMidnight() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day + 1);
    Duration timeUntilMidnight = midnight.difference(now);

    Timer(timeUntilMidnight, () {
      setState(() {
        _initialStepCount = 0;
        _dailySteps = 0;
        _steps = '0';
      });
      _resetDailyStepsAtMidnight(); // Schedule the next reset
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text: "Hello Juan!", style: 'bodyLarge'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                            text: "Health Index Score", style: 'titleSmall'),
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
                    const Expanded(
                        child: DashboardWidget(
                            header: "Glycemic Index", value: 10.0)),
                    SizedBox(width: sizedBoxHeight),
                    const Expanded(
                        child: DashboardWidget(
                            header: "Diet Diversity Score", value: 7.5)),
                  ],
                ),
                SizedBox(height: sizedBoxHeight),
                const Row(
                  children: [
                    Expanded(
                        child:
                            DashboardWidget(header: "Calories", value: 3.45)),
                    SizedBox(width: 10),
                    Expanded(
                        child: DashboardWidget(
                            header: "Carbohydrates", value: 360)),
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
                              FutureBuilder<int>(
                                  future: _stepFuture,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<int> snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                        return const CircularProgressIndicator();
                                      case ConnectionState.active:
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return Text(
                                            snapshot.data!.toString(),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 19, 98, 93),
                                              fontSize: 22,
                                            ),
                                          );
                                          // return Text(
                                          //   'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n\n'
                                          //   'This should persist across restarts.',
                                          // );
                                        }
                                    }
                                  }),
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
                              const Text(
                                "1.5",
                                style: TextStyle(
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
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/history"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            text: "View statistics",
                            style: "bodyMedium",
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                  onTap: () {},
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/historyAll"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            text: "View history",
                            style: "bodyMedium",
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
