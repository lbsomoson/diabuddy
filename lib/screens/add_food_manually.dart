import 'dart:typed_data';

import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/models/meal_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/meal/meal_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFoodManually extends StatefulWidget {
  const AddFoodManually({super.key});

  @override
  State<AddFoodManually> createState() => _AddFoodManuallyState();
}

class _AddFoodManuallyState extends State<AddFoodManually> {
  String? userId;
  final _formKey = GlobalKey<FormState>();
  String mealName = "";
  List<Meal> meals = [];
  List<Meal> allMeals = [];
  List<Meal> foundMeals = [];
  MealIntake mealIntake = MealIntake(
    userId: "",
    foodIds: [],
    imageBytes: Uint8List(0),
    timestamp: null,
    mealTime: "",
    accMeals: Meal(
        mealId: "",
        mealName: "",
        foodCode: "",
        calcium: 0.0,
        carbohydrate: 0.0,
        diversityScore: 0.0,
        energyKcal: 0.0,
        fat: 0.0,
        glycemicIndex: 0.0,
        iron: 0.0,
        phosphorus: 0.0,
        protein: 0.0,
        healthyEatingIndex: 0.0,
        niacin: 0.0,
        cholesterol: 0.0,
        phytochemicalIndex: 0.0,
        potassium: 0.0,
        retinol: 0.0,
        riboflavin: 0.0,
        sodium: [0.0, 0.0],
        thiamin: 0.0,
        totalDietaryFiber: 0.0,
        totalSugar: 0.0,
        vitaminC: 0.0,
        zinc: 0.0,
        betaCarotene: 0.0,
        heiClassification: ""),
  );
  num totalCarbohydrates = 0,
      totalCalories = 0,
      totalHealthIndexScore = 0,
      totalGlycemicIndex = 0,
      totalDietDiversityScore = 0;

  // define time ranges for each meal period
  final breakfastStart = const TimeOfDay(hour: 6, minute: 0); // 6:00 AM
  final breakfastEnd = const TimeOfDay(hour: 10, minute: 0); // 10:00 AM

  final lunchStart = const TimeOfDay(hour: 12, minute: 0); // 12:00 PM
  final lunchEnd = const TimeOfDay(hour: 14, minute: 0); // 2:00 PM

  final dinnerStart = const TimeOfDay(hour: 18, minute: 0); // 6:00 PM
  final dinnerEnd = const TimeOfDay(hour: 21, minute: 0); // 9:00 PM

  String getCurrentMealTime() {
    // get the current time of day
    TimeOfDay now = TimeOfDay.now();

    // check the time range and return the corresponding meal time
    if (_isTimeInRange(now, breakfastStart, breakfastEnd)) {
      return "Breakfast";
    } else if (_isTimeInRange(now, lunchStart, lunchEnd)) {
      return "Lunch";
    } else if (_isTimeInRange(now, dinnerStart, dinnerEnd)) {
      return "Dinner";
    } else {
      return "Snack"; // any other time is considered a snack time
    }
  }

// helper function to check if a time is within a specific range
  bool _isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final currentMinutes = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return currentMinutes >= startMinutes && currentMinutes < endMinutes;
  }

  void computeTotal() {
    for (Meal m in meals) {
      totalCarbohydrates = m.carbohydrate ?? 0 + totalCarbohydrates;
      totalCalories = m.energyKcal ?? 0 + totalCalories;
      totalGlycemicIndex = m.glycemicIndex ?? 0 + totalGlycemicIndex;
      totalDietDiversityScore = m.diversityScore ?? 0 + totalDietDiversityScore;
    }
    print('totalCarbohydrates: $totalCarbohydrates');
    print('totalCalories: $totalCalories');
    print('totalGlycemicIndex: $totalGlycemicIndex');
    print('totalDietDiversityScore: $totalDietDiversityScore');
  }

  @override
  void initState() {
    userId = context.read<UserAuthProvider>().user?.uid;

    context.read<MealBloc>().add(const LoadMeals());
    foundMeals = allMeals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Add Food Manually"),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 80),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        callback: (String val) {
                          setState(() {
                            mealName = val;
                          });
                        },
                        hintText: "Meal Name",
                        type: "String",
                      ),
                      const SizedBox(height: 10),
                      BlocListener<MealBloc, MealState>(
                        listener: (context, state) {
                          if (state is MealLoaded) {
                            // update the allMeals list when meals are loaded
                            setState(() {
                              allMeals = state.meals;
                              foundMeals = allMeals;
                            });
                          }
                          if (state is SingleMealLoaded) {
                            final meal = state.meal;

                            setState(() {
                              // add the meal or perform any action with it
                              meals.add(meal);
                              mealIntake.foodIds.add(meal.mealId!);
                            });
                          } else if (state is MealNotFound) {
                            // show an error message if the medication was not found
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: const Text('Meal not found!'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (state is MealError) {
                            // handle any errors here
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(state.message),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: ButtonWidget(
                          style: 'filled',
                          label: "Add Food",
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<MealBloc>().add(GetMeal(mealName));
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      meals.isEmpty ? const SizedBox() : Divider(color: Colors.grey[400]),
                      const SizedBox(height: 10),
                      meals.isEmpty
                          ? const SizedBox(height: 5)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: meals.length,
                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        dense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          meals[index].mealName!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              onPressed: () {
                                                meals.removeAt(index);
                                                mealIntake.foodIds.removeAt(index);
                                                setState(() {
                                                  meals = meals;
                                                  mealIntake.foodIds = mealIntake.foodIds;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            meals.isEmpty
                ? const SizedBox()
                : Positioned(
                    bottom: 25,
                    left: 25,
                    right: 25,
                    child: ButtonWidget(
                        style: 'filled',
                        label: "Submit",
                        callback: () {
                          mealIntake.userId = userId!;
                          mealIntake.mealTime = getCurrentMealTime();
                          mealIntake.timestamp = DateTime.now();
                          computeTotal();
                          // TODO: DISPLAY MEAL DETAILS SCREEN
                          if (!context.mounted) return;
                          Navigator.pop(context);
                        }),
                  ),
          ],
        )));
  }
}
