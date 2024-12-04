import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/widgets/nutrition.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatefulWidget {
  final MealIntake mealIntake;
  const MealDetailsScreen({required this.mealIntake, super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  String getMonthAndDay(DateTime dateTime) {
    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    // Get the month as a string (1-based index, so subtract 1)
    String monthString = monthNames[dateTime.month - 1];

    // Get the day of the month
    int day = dateTime.day;

    // Return the result formatted as a string
    return "$monthString $day";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/cameraScreen', (Route<dynamic> route) => false);
            },
          ),
          title: TextWidget(text: widget.mealIntake.accMeals!.mealName, style: 'bodyLarge')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.memory(widget.mealIntake.imageBytes)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      widget.mealIntake.accMeals!.heiClassification == ''
                          ? "Food Group"
                          : widget.mealIntake.accMeals!.heiClassification!,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 54, 74, 1),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextWidget(
                        text: getMonthAndDay(widget.mealIntake.timestamp!),
                        style: "bodySmall",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey[400]),
              const SizedBox(
                height: 5,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: NutritionWidget(meal: widget.mealIntake.accMeals!)),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
