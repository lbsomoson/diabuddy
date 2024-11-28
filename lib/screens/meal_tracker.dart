import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/meal_intake/meal_intake_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/meal_info.dart';
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
  double accDietDiversityScore = 0;
  double accHealthyEatingIndex = 0;
  double accCalories = 0;
  double accCarbohydrates = 0;

  final goodText = const Color.fromARGB(255, 19, 98, 93);
  final fairText = const Color.fromRGBO(249, 166, 32, 1);
  final badText = const Color.fromRGBO(249, 32, 32, 1);

  // TODO: CREATE FUNCTION THAT UPLOADS DAILY HEALTH RECORD AT MIDNIGHT
  // TODO: FIX LAYOUT

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
            BlocBuilder<MealIntakeBloc, MealIntakeState>(
              builder: (context, state) {
                if (state is MealIntakeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MealIntakeByDateLoaded) {
                  if (state.mealIntakes.isEmpty) {
                    return Center(
                      child: Column(children: [
                        Icon(
                          Icons.no_food_rounded,
                          size: 125,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("No meals taken yet", style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                      ]),
                    );
                  }
                  // count meals for each mealTime
                  final Map<String, int> mealGroups = {
                    "Breakfast": 0,
                    "Lunch": 0,
                    "Dinner": 0,
                    "Snack": 0,
                  };

                  for (var meal in state.mealIntakes) {
                    final mealTime = meal.mealTime;
                    if (mealGroups.containsKey(mealTime)) {
                      mealGroups[mealTime] = mealGroups[mealTime]! + 1;
                    }
                  }

                  for (var m in state.mealIntakes) {
                    accHealthyEatingIndex = accHealthyEatingIndex + m.accMeals!.healtyEatingIndex!;
                    accDietDiversityScore = accDietDiversityScore + m.accMeals!.diversityScore!;
                    accCalories = accCalories + m.accMeals!.energyKcal!;
                    accCarbohydrates = accCarbohydrates + m.accMeals!.carbohydrate!;
                  }

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Healthy Eating Index",
                            style: TextStyle(color: fairText),
                          ),
                        ],
                      ),
                      Text(accHealthyEatingIndex.toStringAsFixed(0), style: TextStyle(color: fairText, fontSize: 35)),
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(accCalories.toStringAsFixed(2)),
                                  const Text("Calories", style: TextStyle(fontWeight: FontWeight.normal)),
                                ],
                              ),
                              VerticalDivider(
                                thickness: 1,
                                width: 20,
                                color: Colors.grey[400],
                              ),
                              Column(
                                children: [
                                  Text(accCarbohydrates.toStringAsFixed(2)),
                                  const Text(
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
                      mealGroups["Breakfast"] != 0
                          ? Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Breakfast",
                                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                                    )),
                                ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 5.0);
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.mealIntakes.length,
                                  itemBuilder: (context, index) {
                                    MealIntake mealIntake = state.mealIntakes[index];
                                    mealIntake.mealIntakeId = state.mealIntakes[index].mealIntakeId;

                                    if (mealIntake.mealTime == "Breakfast") {
                                      if (mealIntake.accMeals != null) {
                                        return MealInfo(
                                            mealIntake: mealIntake,
                                            mealName: mealIntake.accMeals!.mealName!,
                                            carbs: mealIntake.accMeals!.carbohydrate!.toStringAsFixed(2),
                                            cal: "${mealIntake.accMeals!.energyKcal!.toStringAsFixed(2)} kCal",
                                            gi: mealIntake.accMeals!.glycemicIndex!.toStringAsFixed(2));
                                      }
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      mealGroups["Lunch"] != 0
                          ? Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Lunch",
                                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                                    )),
                                ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 5.0);
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.mealIntakes.length,
                                  itemBuilder: (context, index) {
                                    MealIntake mealIntake = state.mealIntakes[index];
                                    mealIntake.mealIntakeId = state.mealIntakes[index].mealIntakeId;

                                    if (mealIntake.mealTime == "Lunch") {
                                      if (mealIntake.accMeals != null) {
                                        return MealInfo(
                                            mealIntake: mealIntake,
                                            mealName: mealIntake.accMeals!.mealName!,
                                            carbs: mealIntake.accMeals!.carbohydrate!.toStringAsFixed(2),
                                            cal: "${mealIntake.accMeals!.energyKcal!.toStringAsFixed(2)} kCal",
                                            gi: mealIntake.accMeals!.glycemicIndex!.toStringAsFixed(2));
                                      }
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      mealGroups["Dinner"] != 0
                          ? Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Dinner",
                                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                                    )),
                                ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 5.0);
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.mealIntakes.length,
                                  itemBuilder: (context, index) {
                                    MealIntake mealIntake = state.mealIntakes[index];
                                    mealIntake.mealIntakeId = state.mealIntakes[index].mealIntakeId;

                                    if (mealIntake.mealTime == "Dinner") {
                                      if (mealIntake.accMeals != null) {
                                        return MealInfo(
                                            mealIntake: mealIntake,
                                            mealName: mealIntake.accMeals!.mealName!,
                                            carbs: mealIntake.accMeals!.carbohydrate!.toStringAsFixed(2),
                                            cal: "${mealIntake.accMeals!.energyKcal!.toStringAsFixed(2)} kCal",
                                            gi: mealIntake.accMeals!.glycemicIndex!.toStringAsFixed(2));
                                      }
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      mealGroups["Snack"] != 0
                          ? Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Snack",
                                      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
                                    )),
                                ListView.separated(
                                  separatorBuilder: (BuildContext context, int index) {
                                    return const SizedBox(height: 5.0);
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.mealIntakes.length,
                                  itemBuilder: (context, index) {
                                    MealIntake mealIntake = state.mealIntakes[index];
                                    mealIntake.mealIntakeId = state.mealIntakes[index].mealIntakeId;
                                    if (mealIntake.mealTime == "Snack") {
                                      if (mealIntake.accMeals != null) {
                                        return MealInfo(
                                            mealIntake: mealIntake,
                                            mealName: mealIntake.accMeals!.mealName ?? "",
                                            carbs: mealIntake.accMeals!.carbohydrate?.toStringAsFixed(2) ?? "",
                                            cal: "${mealIntake.accMeals!.energyKcal?.toStringAsFixed(2)} kCal",
                                            gi: mealIntake.accMeals!.glycemicIndex?.toStringAsFixed(2) ?? "");
                                      }
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("Error encountered!"),
                  );
                }
              },
            ),
          ]),
        ),
      )),
    );
  }
}
