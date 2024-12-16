import 'package:diabuddy/models/meal_intake_model.dart';
import 'package:diabuddy/services/database_service.dart';
import 'package:flutter/material.dart';

class MealIntakeProvider with ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  late List<MealIntake> mealIntakes, mealIntakesByDate;

  Future<List<MealIntake>> getMealIntakes(String userId) async {
    mealIntakes = await databaseService.getMealIntakes(userId);
    return mealIntakes;
  }

  Future<void> addMealIntake(MealIntake mealIntake) async {
    try {
      await databaseService.insertMealIntake(mealIntake);
      notifyListeners(); // Notify UI that data has changed
    } catch (e) {
      print("Error adding meal intake: $e");
    }
  }

  Future<MealIntake?> getMealIntake(String mealIntakeId) async {
    return await databaseService.getMealIntake(mealIntakeId);
  }

  Future<List<MealIntake>> getMealIntakesByDate(String userId, DateTime date) async {
    mealIntakesByDate = await databaseService.getMealIntakesByDate(userId, date);
    return mealIntakesByDate;
  }
}
