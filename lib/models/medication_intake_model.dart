import 'dart:convert';

class MedicationIntake {
  final String? medicationId;
  String userId;
  String name;
  List<String> time;
  String dose;
  bool isVerifiedBy;
  bool isActive;

  MedicationIntake({
    this.medicationId,
    required this.userId,
    required this.name,
    required this.time,
    required this.dose,
    required this.isVerifiedBy,
    required this.isActive,
  });

  // Factory constructor to instantiate object from json format
  factory MedicationIntake.fromJson(Map<String, dynamic> json) {
    return MedicationIntake(
      medicationId: json['medicationId'],
      userId: json['userId'],
      name: json['name'],
      time: json['time'],
      dose: json['dose'],
      isVerifiedBy: json['isVerifiedBy'],
      isActive: json['isActive'],
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
      'medicationId': medicationIntake.medicationId,
      'userId': medicationIntake.userId,
      'name': medicationIntake.name,
      'time': medicationIntake.time,
      'dose': medicationIntake.dose,
      'isVerifiedBy': medicationIntake.isVerifiedBy,
      'isActive': medicationIntake.isActive,
    };
  }
}
