import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/meal_model.dart';

class MealIntake {
  String? mealIntakeId;
  String userId;
  Uint8List imageBytes;
  DateTime? timestamp;
  List<String> foodIds;
  String mealTime;
  Meal? accMeals;

  MealIntake(
      {this.mealIntakeId,
      required this.userId,
      required this.foodIds,
      required this.imageBytes,
      required this.timestamp,
      required this.mealTime,
      this.accMeals});

  factory MealIntake.fromJson(Map<String, dynamic> json, String id) {
    return MealIntake(
      mealIntakeId: id,
      userId: json['userId'],
      foodIds: List<String>.from(json['foodIds']),
      imageBytes: json['imageBytes'],
      timestamp: json['timestamp'] != null ? (json['timestamp'] as Timestamp).toDate() : null,
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
      'imageBytes': mealIntake.imageBytes,
      'timestamp': mealIntake.timestamp,
      'mealTime': mealIntake.mealTime,
      'accMeals': mealIntake.accMeals?.toJson(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'mealIntakeId': mealIntakeId,
      'userId': userId,
      'foodIds': foodIds.join(', '),
      'imageBytes': base64Encode(imageBytes),
      'timestamp': timestamp!.millisecondsSinceEpoch,
      'mealTime': mealTime,
      'accMeals': accMeals != null ? jsonEncode(accMeals!.toMap()) : null,
    };
  }

  factory MealIntake.fromMap(Map<String, dynamic> map) {
    return MealIntake(
      mealIntakeId: map['mealIntakeId'] as String?,
      userId: map['userId'] as String,
      foodIds: (map['foodIds'] as String).split(','),
      imageBytes: base64Decode(map['imageBytes']),
      timestamp: map['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int) : null,
      mealTime: map['mealTime'] as String,
      accMeals: map['accMeals'] != null ? Meal.fromJson(map['accMeals'], map['accMeals']['mealId']) : null,
    );
  }
}
