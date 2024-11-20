import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;
  const MealDetailsScreen({required this.meal, super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Meal? meal = context.watch<MealProvider>().mealInfo;
    // if (meal == null) {
    //   context.read<MealProvider>().getMealInfo(widget.mealName);
    // }

    return Scaffold(
      appBar: AppBar(title: TextWidget(text: widget.meal.mealName, style: 'bodyLarge')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(image: AssetImage('assets/images/meal.jpg'))),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Food Group",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 54, 74, 1),
                        fontFamily: 'Roboto',
                      )),
                  TextWidget(text: "Dec 22", style: "bodySmall")
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Carbohydrates",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(
                            text: "${widget.meal.carbohydrate.toString()} g", style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Calories",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(
                            text: "${widget.meal.energyKcal.toString()} kCal", style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Glycemic Index",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.glycemicIndex.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Diversity Score",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.diversityScore.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Calcium",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.calcium.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Fat",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.fat.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Iron",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.iron.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Phosphorus",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.phosphorus.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Protein",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.protein.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Niacin",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.niacin.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Cholesterol",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.cholesterol.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Phytochemical Index",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(
                            text: widget.meal.phytochemicalIndex.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Potassium",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.potassium.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Retinol",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.retinol.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Riboflavin",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.riboflavin.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Thiamin",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.thiamin.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Dietary Fiber",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(
                            text: widget.meal.totalDietaryFiber.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Sugar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.totalSugar.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Vitamin C",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.vitaminC.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Zinc",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.zinc.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("beta-carotene",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: widget.meal.betaCarotene.toString(), style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(children: [
                          Text(
                            "Sodium",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text("")
                        ]),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // for (double value in widget.meal.sodium)
                            //   TextWidget(
                            //     text: value.toString(),
                            //     style: "bodySmall",
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
