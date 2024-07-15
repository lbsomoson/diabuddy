class MedicationIntake {
  String? medicationId;
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
  factory MedicationIntake.fromJson(Map<String, dynamic> json, String id) {
    return MedicationIntake(
      medicationId: id,
      userId: json['userId'],
      dose: json['dose'],
      isVerifiedBy: json['isVerifiedBy'],
      isActive: json['isActive'],
      name: json['name'],
      time: List<String>.from(json['time']),
    );
  }

  static List<MedicationIntake> fromJsonArray(
      List<Map<String, dynamic>> jsonData) {
    return jsonData.map<MedicationIntake>((data) {
      String id = data['medicationId'];
      return MedicationIntake.fromJson(data, id);
    }).toList();
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
