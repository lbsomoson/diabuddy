import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/api/meal_api.dart';
import 'package:flutter/material.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealProvider with ChangeNotifier {
  FirebaseMealAPI firebaseService = FirebaseMealAPI();

  Meal? _meal;
  Meal? get mealInfo => _meal;

  Future<Map<String, dynamic>?> getMealInfo(String mealName) async {
    // retrieve meal document
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('meals')
        .where('name', isEqualTo: mealName)
        .get();

    // check if we found a document
    if (snapshot.docs.isNotEmpty) {
      // get the first document's data and ID
      final DocumentSnapshot doc = snapshot.docs.first;
      final Map<String, dynamic> meal = doc.data() as Map<String, dynamic>;
      meal['mealId'] = doc.id;
      return meal;
    }

    return null; // return null if no document was found
  }
}
