import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/meal_intake_model.dart';

class MealIntakeRepository {
  final FirebaseFirestore firestore;

  MealIntakeRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addMealIntake(MealIntake mealIntake) {
    return firestore.collection('meal_intakes').add(mealIntake.toJson(mealIntake));
  }

  Future<void> updateMealIntake(MealIntake mealIntake, String mealIntakeId) async {
    try {
      DocumentSnapshot documentSnapshot = await firestore.collection('meal_intakes').doc(mealIntakeId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> existingData = documentSnapshot.data() as Map<String, dynamic>;
        existingData.remove('name');

        Map<String, dynamic> updatedData = mealIntake.toJson(mealIntake);
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        await firestore.collection('meal_intakes').doc(mealIntakeId).set(mergedData);
      }
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
  }

  Future<void> deleteMealIntake(String medicationId) {
    return firestore.collection('meal_intakes').doc(medicationId).delete();
  }

  Stream<List<MealIntake>> getMealIntakes(String userId) {
    return FirebaseFirestore.instance
        .collection('meal_intakes')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MealIntake.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
