import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealRepository {
  final FirebaseFirestore firestore;

  MealRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<Meal?> getMeal(String mealName) async {
    QuerySnapshot querySnapshot = await firestore
        .collection("meals")
        .where('Meal Name', isEqualTo: mealName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      Map<String, dynamic> mealData =
          documentSnapshot.data() as Map<String, dynamic>;

      return Meal.fromJson(mealData);
    }
    return null;
  }
}
