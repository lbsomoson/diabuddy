import 'dart:async';
import 'package:diabuddy/api/meal_api.dart';
import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record/record_bloc.dart';
import 'package:diabuddy/screens/advice.dart';
import 'package:diabuddy/widgets/dashboard_widgets.dart';
import 'package:diabuddy/widgets/semi_circle_progressbar.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
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
  User? user;
  AppUser? appuser;
  FirebaseMealAPI firestore = FirebaseMealAPI();
  final double sizedBoxHeight = 15;

  DailyHealthRecord record = DailyHealthRecord(
      recordId: "",
      userId: "",
      date: DateTime.now(),
      healthyEatingIndex: 0.0,
      glycemicIndex: 0.0,
      carbohydrates: 0.0,
      energyKcal: 0.0,
      diversityScore: 0.0,
      stepsCount: 0.0);

  @override
  void initState() {
    super.initState();
    // firestore.uploadJsonDataToFirestore();
    // await Permission.activityRecognition.request();
    // await Permission.location.request();
    user = context.read<UserAuthProvider>().user;

    record.userId = user!.uid;

    if (user != null) {
      context.read<RecordBloc>().add(AddRecord(record));
      context.read<RecordBloc>().add(LoadRecord(user!.uid, DateTime.now()));
      context.read<UserAuthProvider>().getUserInfo(user!.uid);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    appuser ??= context.watch<UserAuthProvider>().userInfo;
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

  double getCalorieIntakePercent(cal) {
    double percent = 0.0;
    percent = cal / getCalorieRequirement() * 100;
    print('percent: $percent');
    return percent;
  }

  int getCalorieRequirement() {
    int calReq = 0;

    if (appuser?.age != null && appuser?.gender != null) {
      if (appuser!.gender! == "Male") {
        /* CHILDREN */
        if (appuser!.age! >= 1 && appuser!.age! <= 2) return calReq = 1000;
        if (appuser!.age! >= 3 && appuser!.age! <= 5) return calReq = 1350;
        if (appuser!.age! >= 6 && appuser!.age! <= 9) return calReq = 1600;
        if (appuser!.age! >= 10 && appuser!.age! <= 12) return calReq = 2060;
        if (appuser!.age! >= 13 && appuser!.age! <= 15) return calReq = 2700;
        if (appuser!.age! >= 16 && appuser!.age! <= 18) return calReq = 3010;
        /* ADULT */
        if (appuser!.age! >= 19 && appuser!.age! <= 29) return calReq = 2530;
        if (appuser!.age! >= 30 && appuser!.age! <= 49) return calReq = 2420;
        if (appuser!.age! >= 50 && appuser!.age! <= 59) return calReq = 2420;
        if (appuser!.age! >= 60 && appuser!.age! <= 69) return calReq = 2140;
        if (appuser!.age! >= 70) return calReq = 1960;
      } else if (appuser!.gender == "Female") {
        /* CHILDREN */
        if (appuser!.age! >= 1 && appuser!.age! <= 2) return calReq = 920;
        if (appuser!.age! >= 3 && appuser!.age! <= 5) return calReq = 1260;
        if (appuser!.age! >= 6 && appuser!.age! <= 9) return calReq = 1470;
        if (appuser!.age! >= 10 && appuser!.age! <= 12) return calReq = 1980;
        if (appuser!.age! >= 13 && appuser!.age! <= 15) return calReq = 2170;
        if (appuser!.age! >= 16 && appuser!.age! <= 18) return calReq = 2280;
        /* ADULT */
        if (appuser!.age! >= 19 && appuser!.age! <= 29) return calReq = 1930;
        if (appuser!.age! >= 30 && appuser!.age! <= 49) return calReq = 1870;
        if (appuser!.age! >= 50 && appuser!.age! <= 59) return calReq = 1870;
        if (appuser!.age! >= 60 && appuser!.age! <= 69) return calReq = 1610;
        if (appuser!.age! >= 70) return calReq = 1540;
      }
    }

    return calReq;
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user;
    List<String> nameParts = user!.displayName!.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocListener<RecordBloc, RecordState>(
              listener: (context, state) {
                if (state is RecordUpdated) {
                  context.read<RecordBloc>().add(LoadRecord(user.uid, DateTime.now()));
                }
              },
              child: BlocBuilder<RecordBloc, RecordState>(
                builder: (context, state) {
                  if (state is RecordLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SingleRecordLoaded) {
                    DailyHealthRecord r = state.record;
                    return buildDashboard(r, firstName);
                  } else if (state is RecordNotFound) {
                    context.read<RecordBloc>().add(AddRecord(record));
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                      child: Text("Something went wrong."),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDashboard(r, firstName) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(text: "Hello, $firstName!", style: 'bodyLarge'),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AdviceScreen(
                      bmi: 'overweight',
                      physicalActivity: 'light',
                    );
                  }));
                },
                icon: Icon(
                  Icons.lightbulb,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        Divider(
          color: Colors.grey[400],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              r.energyKcal.toString(),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              " / ${getCalorieRequirement()} kCal",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color.fromRGBO(100, 204, 197, 0.5),
              ),
            ),
          ],
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
          child: CircleProgressIndicator(title: "Title", value: getCalorieIntakePercent(r.energyKcal)),
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
            Expanded(child: DashboardWidget(header: "Glycemic Index", value: r.glycemicIndex)),
            SizedBox(width: sizedBoxHeight),
            Expanded(child: DashboardWidget(header: "Diet Diversity Score", value: r.diversityScore)),
          ],
        ),
        SizedBox(height: sizedBoxHeight),
        Row(
          children: [
            Expanded(child: DashboardWidget(header: "Calories", value: r.energyKcal)),
            const SizedBox(width: 10),
            Expanded(
                child: DashboardWidget(header: "Carbohydrates", value: r.carbohydrates, caloriesValue: r.energyKcal)),
          ],
        ),
        SizedBox(height: sizedBoxHeight),
      ],
    );
  }
}
