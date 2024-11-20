import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class NutritionWidget extends StatelessWidget {
  final Meal accMeal;

  const NutritionWidget({required this.accMeal, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  TextWidget(text: "${accMeal.carbohydrate!.toStringAsFixed(2)} g", style: "bodySmall")
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
                  TextWidget(text: "${accMeal.energyKcal!.toStringAsFixed(2)} kCal", style: "bodySmall")
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
                  TextWidget(text: accMeal.glycemicIndex!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.diversityScore!.toStringAsFixed(2), style: "bodySmall")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Healthy Eating Index",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 54, 74, 1),
                        fontFamily: 'Roboto',
                      )),
                  TextWidget(text: accMeal.healtyEatingIndex!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.calcium!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.fat!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.iron!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.phosphorus!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.protein!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.niacin!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.cholesterol!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.phytochemicalIndex!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.potassium!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.retinol!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.riboflavin!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.thiamin!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.totalDietaryFiber!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.totalSugar!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.vitaminC!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.zinc!.toStringAsFixed(2), style: "bodySmall")
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
                  TextWidget(text: accMeal.betaCarotene!.toStringAsFixed(2), style: "bodySmall")
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
                      for (double? value in accMeal.sodium ?? [])
                        TextWidget(
                          text: value!.toStringAsFixed(2),
                          style: "bodySmall",
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
