import 'dart:convert';

class Medication {
  final String? medicationId;
  final String userId;
  bool isActive;
  List<Map<String, dynamic>>? foodRecommendation;
  String? verifiedBy;

  Medication({
    this.medicationId,
    required this.userId,
    required this.isActive,
    this.foodRecommendation,
    this.verifiedBy,
  });

  // Factory constructor to instantiate object from json format
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      userId: json['userId'],
      medicationId: json['medicationId'],
      isActive: json['isActive'],
      foodRecommendation: json['foodRecommendation'],
      verifiedBy: json['verifiedBy'],
    );
  }

  static List<Medication> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Medication>((dynamic d) => Medication.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Medication medication) {
    return {
      'userId': medication.userId,
      'medicationId': medication.medicationId,
      'isActive': medication.isActive,
      'foodRecommendation': medication.foodRecommendation,
      'verifiedBy': medication.verifiedBy,
    };
  }
}
