import 'package:diabuddy/api/meal_api.dart';
import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record/record_bloc.dart';
import 'package:diabuddy/screens/advice.dart';
import 'package:diabuddy/services/database_service.dart';
import 'package:diabuddy/widgets/dashboard_widgets.dart';
import 'package:diabuddy/widgets/semi_circle_progressbar.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? user;
  AppUser? appuser;
  DatabaseService db = DatabaseService();

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
    user = context.read<UserAuthProvider>().user;

    record.userId = user!.uid;

    if (user != null) {
      // context.read<RecordBloc>().add(AddRecord(record));
      context.read<RecordBloc>().add(LoadRecord(user!.uid, DateTime.now()));
      context.read<UserAuthProvider>().getUserInfo(user!.uid);
    }

    db.printTableContents('appointments');
    db.printTableContents('medications');
    db.printTableSchema('appointments');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    appuser ??= context.watch<UserAuthProvider>().userInfo;
  }

  double getCalorieIntakePercent(cal) {
    double percent = 0.0;
    percent = cal / getCalorieRequirement() * 100;
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
            child: BlocBuilder<RecordBloc, RecordState>(
              builder: (context, state) {
                if (state is RecordLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SingleRecordLoaded) {
                  DailyHealthRecord record = state.record;
                  return buildDashboard(record, firstName);
                } else if (state is RecordUpdated) {
                  DailyHealthRecord updatedRecord = state.record;
                  return buildDashboard(updatedRecord, firstName);
                } else if (state is RecordNotFound) {
                  context.read<RecordBloc>().add(AddRecord(record));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecordError) {
                  print("Record Error: ${state.message}");
                  return const Center(child: CircularProgressIndicator());
                } else {
                  print("++++ $state");
                  return const Center(child: Text("Something went wrong."));
                }
              },
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
              r.energyKcal.toStringAsFixed(2),
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
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.shoePrints,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text((r.energyKcal * 25).ceil().toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 19, 98, 93),
                      fontSize: 22,
                    )),
                const Text(
                  "steps to burn kCal",
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
        const SizedBox(height: 40),
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
