import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/meal_info.dart';
import 'package:flutter/material.dart';

class MealTrackerScreen extends StatefulWidget {
  const MealTrackerScreen({super.key});

  @override
  State<MealTrackerScreen> createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {
  final goodText = const Color.fromARGB(255, 19, 98, 93);
  final fairText = const Color.fromRGBO(249, 166, 32, 1);
  final badText = const Color.fromRGBO(249, 32, 32, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Daily Meal Tracker"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Diet Diversity Score",
                  style: TextStyle(color: fairText),
                ),
              ],
            ),
            Text("7.5", style: TextStyle(color: fairText, fontSize: 35)),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100]),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      children: [
                        Text("3.45"),
                        Text("Calories",
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 1,
                      width: 20,
                      color: Colors.grey[400],
                    ),
                    const Column(
                      children: [
                        Text("360"),
                        Text(
                          "Carbohydrates",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Breakfast",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const MealInfo(
                mealName: "Sunny Sideup and Rice",
                carbs: "130g",
                cal: "0.89 kCal",
                gi: "2.5"),
            const SizedBox(height: 10),
            const MealInfo(
                mealName: "Adobo", carbs: "130g", cal: "0.89 kCal", gi: "2.5"),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Lunch",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const MealInfo(
                mealName: "Sinigang and Rice",
                carbs: "130g",
                cal: "0.89 kCal",
                gi: "2.5"),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
          ]),
        ),
      )),
    );
  }
}
