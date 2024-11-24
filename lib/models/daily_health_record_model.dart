import 'package:cloud_firestore/cloud_firestore.dart';

class DailyHealthRecord {
  final String? recordId;
  final String? userId;
  DateTime date;
  double healthyIndexScore;
  int totalGlycemicIndex;
  double totalCarbohydrates;
  double totalCalories;
  int dietDiversityScore;
  int stepsCount;

  DailyHealthRecord({
    this.recordId,
    this.userId,
    required this.date,
    required this.healthyIndexScore,
    required this.totalGlycemicIndex,
    required this.totalCarbohydrates,
    required this.totalCalories,
    required this.dietDiversityScore,
    required this.stepsCount,
  });

  // Factory constructor to instantiate object from json format
  factory DailyHealthRecord.fromJson(Map<String, dynamic> json, String id) {
    return DailyHealthRecord(
      recordId: id,
      userId: json['userId'],
      date: (json['date'] as Timestamp).toDate(),
      healthyIndexScore: json['healthyIndexScore'],
      totalGlycemicIndex: json['totalGlycemicIndex'],
      totalCarbohydrates: json['totalCarbohydrates'],
      totalCalories: json['totalCalories'],
      dietDiversityScore: json['dietDiversityScore'],
      stepsCount: json['stepsCount'],
    );
  }

  static List<DailyHealthRecord> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<DailyHealthRecord>((data) {
      String id = data['mealIntakeId'];
      return DailyHealthRecord.fromJson(data, id);
    }).toList();
  }

  Map<String, dynamic> toJson(DailyHealthRecord medication) {
    return {
      'recordId': medication.recordId,
      'userId': medication.userId,
      'date': medication.date,
      'healthyIndexScore': medication.healthyIndexScore,
      'totalGlycemicIndex': medication.totalGlycemicIndex,
      'totalCarbohydrates': medication.totalCarbohydrates,
      'totalCalories': medication.totalCalories,
      'dietDiversityScore': medication.dietDiversityScore,
      'stepsCount': medication.stepsCount,
    };
  }

  addDailyHealthRecord(Map<String, dynamic> json) {}
}
