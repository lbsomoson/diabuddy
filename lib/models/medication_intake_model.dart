import 'dart:convert';

class MedicationIntake {
  final String? id;
  final String medicineId;
  String dateTime;
  double dose;
  String remarks;

  MedicationIntake({
    this.id,
    required this.medicineId,
    required this.dateTime,
    required this.dose,
    required this.remarks,
  });

  // Factory constructor to instantiate object from json format
  factory MedicationIntake.fromJson(Map<String, dynamic> json) {
    return MedicationIntake(
      id: json['id'],
      medicineId: json['medicineId'],
      dateTime: json['dateTime'],
      dose: json['dose'],
      remarks: json['remarks'],
    );
  }

  static List<MedicationIntake> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<MedicationIntake>((dynamic d) => MedicationIntake.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(MedicationIntake medicationIntake) {
    return {
      'userId': medicationIntake.id,
      'medicationId': medicationIntake.medicineId,
      'isActive': medicationIntake.dateTime,
      'foodRecommendation': medicationIntake.dose,
      'verifiedBy': medicationIntake.remarks,
    };
  }
}
