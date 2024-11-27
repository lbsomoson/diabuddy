import 'package:cloud_firestore/cloud_firestore.dart';

class DailyHealthRecord {
  final String? recordId;
  String? userId;
  DateTime date;
  double healthyEatingIndex;
  double diversityScore;
  double glycemicIndex;
  double carbohydrates;
  double energyKcal;
  double stepsCount;

  DailyHealthRecord({
    this.recordId,
    this.userId,
    required this.date,
    required this.healthyEatingIndex,
    required this.glycemicIndex,
    required this.carbohydrates,
    required this.energyKcal,
    required this.diversityScore,
    required this.stepsCount,
  });

  // Factory constructor to instantiate object from json format
  factory DailyHealthRecord.fromJson(Map<String, dynamic> json, String id) {
    return DailyHealthRecord(
      recordId: id,
      userId: json['userId'],
      date: (json['date'] as Timestamp).toDate(),
      healthyEatingIndex: json['healthyEatingIndex'],
      glycemicIndex: json['glycemicIndex'],
      carbohydrates: json['carbohydrates'],
      energyKcal: json['energyKcal'],
      diversityScore: json['diversityScore'],
      stepsCount: json['stepsCount'],
    );
  }

  static List<DailyHealthRecord> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<DailyHealthRecord>((data) {
      String id = data['mealIntakeId'];
      return DailyHealthRecord.fromJson(data, id);
    }).toList();
  }

  Map<String, dynamic> toJson(DailyHealthRecord dhr) {
    return {
      'recordId': dhr.recordId,
      'userId': dhr.userId,
      'date': dhr.date,
      'healthyEatingIndex': dhr.healthyEatingIndex,
      'glycemicIndex': dhr.glycemicIndex,
      'carbohydrates': dhr.carbohydrates,
      'energyKcal': dhr.energyKcal,
      'diversityScore': dhr.diversityScore,
      'stepsCount': dhr.stepsCount,
    };
  }

  addDailyHealthRecord(Map<String, dynamic> json) {}
}
