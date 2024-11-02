import 'package:cloud_firestore/cloud_firestore.dart';

class MealIntake {
  String? mealIntakeId;
  String photoUrl;
  String proofPath;
  DateTime? timestamp;
  List<String> foodIds;
  String mealTime;
  num totalCarbohydrates;
  num totalCalories;
  num totalHealthIndexScore;
  num totalGlycemicIndex;
  num totalDietDiversityScore;

  MealIntake({
    this.mealIntakeId,
    required this.foodIds,
    required this.photoUrl,
    required this.proofPath,
    required this.timestamp,
    required this.mealTime,
    required this.totalCarbohydrates,
    required this.totalCalories,
    required this.totalHealthIndexScore,
    required this.totalGlycemicIndex,
    required this.totalDietDiversityScore,
  });

  factory MealIntake.fromJson(Map<String, dynamic> json, String id) {
    return MealIntake(
        mealIntakeId: id,
        foodIds: json['foodIds'],
        photoUrl: json['photoUrl'],
        proofPath: json['proofPath'],
        timestamp: (json['date'] as Timestamp).toDate(),
        mealTime: json['mealTime'],
        totalCarbohydrates: json['totalCarbohydrates'],
        totalCalories: json['totalCalories'],
        totalHealthIndexScore: json['totalHealthIndexScore'],
        totalGlycemicIndex: json['totalGlycemicIndex'],
        totalDietDiversityScore: json['totalDietDiversityScore']);
  }

  static List<MealIntake> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<MealIntake>((data) {
      String id = data['mealIntakeId'];
      return MealIntake.fromJson(data, id);
    }).toList();
  }

  Map<String, dynamic> toJson(MealIntake mealIntake) {
    return {
      'mealIntakeId': mealIntake.mealIntakeId,
      'foodIds': mealIntake.foodIds,
      'photoUrl': mealIntake.photoUrl,
      'proofPath': mealIntake.proofPath,
      'timestamp': mealIntake.timestamp,
      'mealTime': mealIntake.mealTime,
      'totalCarbohydrates': mealIntake.totalCarbohydrates,
      'totalCalories': mealIntake.totalCalories,
      'totalHealthIndexScore': mealIntake.totalHealthIndexScore,
      'totalGlycemicIndex': mealIntake.totalGlycemicIndex,
      'totalDietDiversityScore': mealIntake.totalDietDiversityScore,
    };
  }
}
