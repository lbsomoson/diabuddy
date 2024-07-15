import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? appointmentId;
  String title;
  String doctorName;
  String? clinicName;
  DateTime? date;
  String userId;

  Appointment({
    this.appointmentId,
    required this.title,
    required this.doctorName,
    this.clinicName,
    required this.date,
    required this.userId,
  });

  // Factory constructor to instantiate object from json format
  factory Appointment.fromJson(Map<String, dynamic> json, String id) {
    return Appointment(
        appointmentId: id,
        title: json['title'],
        doctorName: json['doctorName'],
        clinicName: json['clinicName'],
        date: (json['date'] as Timestamp).toDate(),
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
      'title': appointment.title,
      'doctorName': appointment.doctorName,
      'clinicName': appointment.clinicName,
      'date': appointment.date,
      'userId': appointment.userId,
    };
  }
}
