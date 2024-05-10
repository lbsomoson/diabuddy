import 'dart:convert';

class Appointment {
  final String? appointmentId;
  String title;
  String doctorName;
  String? clinicName;

  Appointment({
    this.appointmentId,
    required this.title,
    required this.doctorName,
    this.clinicName,
  });

  // Factory constructor to instantiate object from json format
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      appointmentId: json['appointmentId'],
      title: json['title'],
      doctorName: json['doctorName'],
      clinicName: json['clinicName'],
    );
  }

  static List<Appointment> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<Appointment>((dynamic d) => Appointment.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(Appointment medication) {
    return {
      'appointmentId': medication.appointmentId,
      'title': medication.title,
      'doctorName': medication.doctorName,
      'clinicName': medication.clinicName,
    };
  }
}
