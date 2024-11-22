import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealIntake {
  String? mealIntakeId;
  String userId;
  String photoUrl;
  String proofPath;
  DateTime? timestamp;
  List<String> foodIds;
  String mealTime;
  Meal? accMeals;

  MealIntake(
      {this.mealIntakeId,
      required this.userId,
      required this.foodIds,
      required this.photoUrl,
      required this.proofPath,
      required this.timestamp,
      required this.mealTime,
      this.accMeals});

  factory MealIntake.fromJson(Map<String, dynamic> json, String id) {
    print(json['accMeals']);

    return MealIntake(
      mealIntakeId: id,
      userId: json['userId'],
      foodIds: List<String>.from(json['foodIds']),
      photoUrl: json['photoUrl'],
      proofPath: json['proofPath'],
      timestamp: json['date'] != null ? (json['date'] as Timestamp).toDate() : null,
      mealTime: json['mealTime'],
      accMeals: json['accMeals'] != null ? Meal.fromJson(json['accMeals'] as Map<String, dynamic>, id) : null,
    );
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
      'userId': mealIntake.userId,
      'foodIds': mealIntake.foodIds,
      'photoUrl': mealIntake.photoUrl,
      'proofPath': mealIntake.proofPath,
      'timestamp': mealIntake.timestamp,
      'mealTime': mealIntake.mealTime,
      'accMeals': mealIntake.accMeals?.toJson(),
    };
  }
}
