import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/screens/meal_details.dart';
import 'package:flutter/material.dart';

class MealInfo extends StatefulWidget {
  final MealIntake mealIntake;
  final String mealName, carbs, cal, gi;
  const MealInfo(
      {required this.mealIntake,
      required this.mealName,
      required this.carbs,
      required this.cal,
      required this.gi,
      super.key});

  @override
  State<MealInfo> createState() => _MealInfoState();
}

class _MealInfoState extends State<MealInfo> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      splashColor: const Color.fromRGBO(3, 198, 185, 0.296),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MealDetailsScreen(mealIntake: widget.mealIntake);
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.mealName,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.carbs,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        const Text(
                          " of carbohydrates",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.cal,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        const Text(
                          " of calories",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.gi,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        const Text(
                          " glycemic index",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
