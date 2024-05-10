import 'dart:convert';

class BMIHistory {
  final String? logiId;
  final String userId;
  double height;
  double weight;
  String? verifiedBy;
  String date;

  BMIHistory({
    this.logiId,
    required this.userId,
    required this.height,
    required this.weight,
    required this.verifiedBy,
    required this.date,
  });

  // Factory constructor to instantiate object from json format
  factory BMIHistory.fromJson(Map<String, dynamic> json) {
    return BMIHistory(
      logiId: json['logiId'],
      userId: json['userId'],
      height: json['height'],
      weight: json['weight'],
      verifiedBy: json['verifiedBy'],
      date: json['date'],
    );
  }

  static List<BMIHistory> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<BMIHistory>((dynamic d) => BMIHistory.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(BMIHistory medication) {
    return {
      'logiId': medication.logiId,
      'userId': medication.userId,
      'height': medication.height,
      'weight': medication.weight,
      'verifiedBy': medication.verifiedBy,
      'date': medication.date,
    };
  }
}
