import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/meal_intake/meal_intake_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/meal_info.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealTrackerScreen extends StatefulWidget {
  const MealTrackerScreen({super.key});

  @override
  State<MealTrackerScreen> createState() => _MealTrackerScreenState();
}

class _MealTrackerScreenState extends State<MealTrackerScreen> {
  String? userId;
  List<MealIntake> mealsToday = [];

  final goodText = const Color.fromARGB(255, 19, 98, 93);
  final fairText = const Color.fromRGBO(249, 166, 32, 1);
  final badText = const Color.fromRGBO(249, 32, 32, 1);

  @override
  void initState() {
    super.initState();
    userId = context.read<UserAuthProvider>().user?.uid;

    context.read<MealIntakeBloc>().add(LoadMealIntakeByDate(userId!, DateTime.now()));
  }

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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Column(
                      children: [
                        Text("3.45"),
                        Text("Calories", style: TextStyle(fontWeight: FontWeight.normal)),
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
            BlocBuilder<MealIntakeBloc, MealIntakeState>(
              builder: (context, state) {
                if (state is MealIntakeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MealIntakeByDateLoaded) {
                  if (state.mealIntakes.isEmpty) {
                    return const Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Center(child: Text2Widget(text: "No meals taken yet", style: 'body2'))]),
                    );
                  }
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: state.mealIntakes.isNotEmpty
                            ? Text(
                                "Breakfast",
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                              )
                            : const SizedBox(),
                      ),
                      ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5.0);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.mealIntakes.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mealIntake = state.mealIntakes[index];
                          mealIntake['mealIntakeId'] = state.mealIntakes[index]['mealIntakeId'];

                          if (mealIntake['mealTime'] == "Breakfast") {
                            if (mealIntake['accMeals'] != null) {
                              return MealInfo(
                                  mealName: mealIntake['accMeals']['mealName'],
                                  carbs: mealIntake['accMeals']['carbohydrate'].toStringAsFixed(2),
                                  cal: "${mealIntake['accMeals']['energyKcal'].toStringAsFixed(2)} kCal",
                                  gi: mealIntake['accMeals']['glycemicIndex'].toStringAsFixed(2));
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: state.mealIntakes.isNotEmpty
                            ? Text(
                                "Lunch",
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                              )
                            : const SizedBox(),
                      ),
                      ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5.0);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.mealIntakes.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mealIntake = state.mealIntakes[index];
                          mealIntake['mealIntakeId'] = state.mealIntakes[index]['mealIntakeId'];

                          if (mealIntake['mealTime'] == "Lunch") {
                            if (mealIntake['accMeals'] != null) {
                              return MealInfo(
                                  mealName: mealIntake['accMeals']['mealName'],
                                  carbs: mealIntake['accMeals']['carbohydrate'].toStringAsFixed(2),
                                  cal: "${mealIntake['accMeals']['energyKcal'].toStringAsFixed(2)} kCal",
                                  gi: mealIntake['accMeals']['glycemicIndex'].toStringAsFixed(2));
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: state.mealIntakes.isNotEmpty
                            ? Text(
                                "Dinner",
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                              )
                            : const SizedBox(),
                      ),
                      ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5.0);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.mealIntakes.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mealIntake = state.mealIntakes[index];
                          mealIntake['mealIntakeId'] = state.mealIntakes[index]['mealIntakeId'];

                          if (mealIntake['mealTime'] == "Dinner") {
                            if (mealIntake['accMeals'] != null) {
                              return MealInfo(
                                  mealName: mealIntake['accMeals']['mealName'],
                                  carbs: mealIntake['accMeals']['carbohydrate'].toStringAsFixed(2),
                                  cal: "${mealIntake['accMeals']['energyKcal'].toStringAsFixed(2)} kCal",
                                  gi: mealIntake['accMeals']['glycemicIndex'].toStringAsFixed(2));
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: state.mealIntakes.isNotEmpty
                            ? Text(
                                "Snack",
                                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                              )
                            : const SizedBox(),
                      ),
                      ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 5.0);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.mealIntakes.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> mealIntake = state.mealIntakes[index];
                          mealIntake['mealIntakeId'] = state.mealIntakes[index]['mealIntakeId'];

                          if (mealIntake['mealTime'] == "Snack") {
                            if (mealIntake['accMeals'] != null) {
                              return MealInfo(
                                  mealName: mealIntake['accMeals']['mealName'],
                                  carbs: mealIntake['accMeals']['carbohydrate'].toStringAsFixed(2),
                                  cal: "${mealIntake['accMeals']['energyKcal'].toStringAsFixed(2)} kCal",
                                  gi: mealIntake['accMeals']['glycemicIndex'].toStringAsFixed(2));
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                          return null;
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Error encountered!"),
                  );
                }
              },
            ),

            // Row(
            //   children: [
            //     Text(
            //       "Breakfast",
            //       textAlign: TextAlign.left,
            //       style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // const MealInfo(mealName: "Sunny Sideup and Rice", carbs: "130g", cal: "0.89 kCal", gi: "2.5"),
            // const SizedBox(height: 10),
            // const MealInfo(mealName: "Adobo", carbs: "130g", cal: "0.89 kCal", gi: "2.5"),
            // const SizedBox(height: 10),
            // Row(
            //   children: [
            //     Text(
            //       "Lunch",
            //       textAlign: TextAlign.left,
            //       style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10),
            // const MealInfo(mealName: "Sinigang and Rice", carbs: "130g", cal: "0.89 kCal", gi: "2.5"),
            // const SizedBox(height: 10),
            // const SizedBox(height: 10),
          ]),
        ),
      )),
    );
  }
}
