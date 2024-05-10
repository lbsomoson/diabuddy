import 'dart:convert';

class DailyHealthRecord {
  final String? recordId;
  final String? userId;
  String date;
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
  factory DailyHealthRecord.fromJson(Map<String, dynamic> json) {
    return DailyHealthRecord(
      recordId: json['recordId'],
      userId: json['userId'],
      date: json['date'],
      healthyIndexScore: json['healthyIndexScore'],
      totalGlycemicIndex: json['totalGlycemicIndex'],
      totalCarbohydrates: json['totalCarbohydrates'],
      totalCalories: json['totalCalories'],
      dietDiversityScore: json['dietDiversityScore'],
      stepsCount: json['stepsCount'],
    );
  }

  static List<DailyHealthRecord> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<DailyHealthRecord>((dynamic d) => DailyHealthRecord.fromJson(d))
        .toList();
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
}
