import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/meal_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class FirebaseMealAPI {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseMealAPI() {
    uploadJsonDataToFirestore();
  }

  Future<void> uploadJsonDataToFirestore() async {
    // Check if the data has already been loaded
    var snapshot =
        await firestore.collection('metadata').doc('dataLoaded').get();
    if (snapshot.exists) {
      print('Data has already been loaded.');
      return;
    }

    // If data hasn't been loaded, proceed with loading and uploading
    Map<String, dynamic> jsonData = await loadJsonData();
    List<dynamic> meals = jsonData['meals'];

    for (var meal in meals) {
      await firestore.collection('meals').add({
        'Meal Name': meal['Meal Name'],
        'Food Code': meal['Food Code'],
        'Carbohydrate': meal['Carbohydrate'],
        'Total Dietary Fiber': meal['Total Dietary Fiber'],
        'Total Sugar': meal['Total Sugar'],
        'Protein': meal['Protein'],
        'Fat': meal['Fat'],
        'Energy (Kcal)': meal['Energy (Kcal)'],
        'Sodium': meal['Sodium'],
        'Cholesterol': meal['Cholesterol'],
        'Calcium': meal['Calcium'],
        'Phosphorus': meal['Phosphorus'],
        'Iron': meal['Iron'],
        'Potassium': meal['Potassium'],
        'Zinc': meal['Zinc'],
        'Retinol': meal['Retinol'],
        'beta-carotene': meal['beta-carotene'],
        'Thiamin': meal['Thiamin'],
        'Riboflavin': meal['Riboflavin'],
        'Niacin': meal['Niacin'],
        'Vitamin C': meal['Vitamin C'],
        'Glycemic Index': meal['Glycemic Index'],
        'Diversity Score': meal['Diversity Score'],
        'Phytochemical Index': meal['Phytochemical Index'],
      });
    }

    // Mark that the data has been loaded
    await firestore
        .collection('metadata')
        .doc('dataLoaded')
        .set({'loaded': true});
    print('Data loaded successfully.');
  }

  Future<Map<String, dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/meal.json');
    return jsonDecode(jsonString);
  }

  Future<Meal?> getMealInfo(String mealName) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("meals")
          .where('Meal Name', isEqualTo: mealName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        return Meal.fromJson(data);
      }
    } catch (e) {
      print("Error getting meal info: $e");
    }
    return null;
  }
}
