import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? appointmentId;
  int channelId;
  String title;
  String doctorName;
  String clinicName;
  DateTime date;
  String userId;

  Appointment({
    this.appointmentId,
    required this.channelId,
    required this.title,
    required this.doctorName,
    required this.clinicName,
    required this.date,
    required this.userId,
  });

  // Factory constructor to instantiate object from json format
  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    return Appointment(
        appointmentId: id,
        channelId: json['channelId'],
        title: json['title'],
        doctorName: json['doctorName'],
        clinicName: json['clinicName'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        userId: json['userId']);
  }

  static List<Appointment> fromJsonArray(List<Map<String, dynamic>> jsonData) {
    return jsonData.map<Appointment>((data) {
      String id = data['appointmentId'];
      return Appointment.fromJson(data, id);
    }).toList();
  }

  Map<String, dynamic> toJson(Appointment appointment) {
    return {
      'appointmentId': appointment.appointmentId,
      'channelId': appointment.channelId,
      'title': appointment.title,
      'doctorName': appointment.doctorName,
      'clinicName': appointment.clinicName,
      'date': Timestamp.fromDate(appointment.date),
      'userId': appointment.userId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'channelId': channelId,
      'title': title,
      'doctorName': doctorName,
      'clinicName': clinicName,
      'date': date.millisecondsSinceEpoch,
    };
  }
}
