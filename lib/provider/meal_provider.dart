import 'package:diabuddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealProvider with ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  late List<Meal> meals;

  Future<List<Meal>> getMeals() async {
    meals = await databaseService.getMeals();
    return meals;
  }
}
