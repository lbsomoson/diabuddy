import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/api/meal_api.dart';
import 'package:diabuddy/widgets/dashboard_widgets.dart';
import 'package:diabuddy/widgets/semi_circle_progressbar.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double sizedBoxHeight = 15;

  FirebaseMealAPI firestore = FirebaseMealAPI();
  @override
  void initState() {
    super.initState();
    firestore.uploadJsonDataToFirestore();
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey[400]),
              SizedBox(
                height: sizedBoxHeight,
              ),
              const SemiCircleProgressBar(title: "Title"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                      child: DashboardWidget(
                          header: "Glycemic Index", value: 10.0)),
                  SizedBox(
                    width: sizedBoxHeight,
                  ),
                  const Expanded(
                      child: DashboardWidget(
                          header: "Diet Diversity Score", value: 7.5)),
                ],
              ),
              SizedBox(
                height: sizedBoxHeight,
              ),
              const Row(
                children: [
                  Expanded(
                      child: DashboardWidget(header: "Calories", value: 3.45)),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child:
                          DashboardWidget(header: "Carbohydrates", value: 360)),
                ],
              ),
              SizedBox(
                height: sizedBoxHeight,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[100]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Activity Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic)),
                      SizedBox(
                        height: sizedBoxHeight,
                      ),
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
                              const Text("4500",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 19, 98, 93),
                                      fontSize: 22)),
                              const Text("steps",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15))
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.fire,
                                size: 50,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Text("1.5",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 19, 98, 93),
                                      fontSize: 22)),
                              const Text("kCal burned",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15))
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: sizedBoxHeight,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                onTap: () {},
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/history"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
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
                              text: "View statistics", style: "bodyMedium"),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          )
                        ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
                onTap: () {},
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/historyAll"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
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
                              text: "View history", style: "bodyMedium"),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30,
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
