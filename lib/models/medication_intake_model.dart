class MedicationIntake {
  String? medicationId;
  String userId;
  int channelId;
  String name;
  List<String> time;
  String dose;
  String frequency;
  Map<String, dynamic>? verifiedBy;
  bool isActive;

  MedicationIntake({
    this.medicationId,
    required this.channelId,
    required this.userId,
    required this.name,
    required this.time,
    required this.dose,
    required this.frequency,
    required this.verifiedBy,
    required this.isActive,
  });

  // Factory constructor to instantiate object from json format
  factory MedicationIntake.fromJson(Map<String, dynamic> json, String id) {
    return MedicationIntake(
      medicationId: id,
      channelId: json['channelId'],
      userId: json['userId'],
      dose: json['dose'],
      frequency: json['frequency'],
      verifiedBy: json['verifiedBy'],
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
      'channelId': medicationIntake.channelId,
      'name': medicationIntake.name,
      'time': medicationIntake.time,
      'dose': medicationIntake.dose,
      'frequency': medicationIntake.frequency,
      'verifiedBy': medicationIntake.verifiedBy,
      'isActive': medicationIntake.isActive,
    };
  }
}
