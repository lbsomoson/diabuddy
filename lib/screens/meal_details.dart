import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class MealDetailsScreen extends StatefulWidget {
  // final String name, date, carbs, cal, gi;
  const MealDetailsScreen(
      // required this.name,
      // required this.date,
      // required this.carbs,
      // required this.cal,
      // required this.gi,
      {super.key});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const TextWidget(
              text: "Bacon, Egg and Rice", style: 'bodyLarge')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                      const Image(image: AssetImage('assets/images/meal.jpg'))),
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
                padding: const EdgeInsets.only(left: 15),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Carbohydrates",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: "130 g", style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Calories",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: "0.89 kCal", style: "bodySmall")
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Glycemic Index",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        TextWidget(text: "2.5", style: "bodySmall")
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey[400]),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Ingredients",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 54, 74, 1),
                        fontFamily: 'Roboto',
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text("Bacon",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        Text("Egg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        Text("Rice",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        Text("Oil",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                        Text("Salt",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(4, 54, 74, 1),
                              fontFamily: 'Roboto',
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: Colors.grey[400]),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Remarks",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(4, 54, 74, 1),
                        fontFamily: 'Roboto',
                      )),
                ],
              ),
              const TextWidget(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                  style: 'bodySmall'),
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
