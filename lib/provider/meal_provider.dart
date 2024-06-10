import 'package:diabuddy/api/meal_api.dart';
import 'package:flutter/material.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealProvider with ChangeNotifier {
  FirebaseMealAPI firebaseService = FirebaseMealAPI();

  Meal? _meal;
  Meal? get mealInfo => _meal;

  Future<void> getMealInfo(String mealName) async {
    _meal = await firebaseService.getMealInfo(mealName);
    notifyListeners();
  }
}
