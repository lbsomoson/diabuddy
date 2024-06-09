import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/api/appointment_api.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  FirebaseAppointmentAPI firebaseService = FirebaseAppointmentAPI();

  late Stream<QuerySnapshot> _appointmentsStream;

  Stream<QuerySnapshot> getAppointments(String id) {
    _appointmentsStream = firebaseService.getAppointments(id);
    notifyListeners();
    return _appointmentsStream;
  }

  Future<Map<String, dynamic>> getAppointment(String id) async {
    Map<String, dynamic> appointment = await firebaseService.getAppointment(id);
    notifyListeners();
    return appointment;
  }

  Future<String> addAppointment(Map<String, dynamic> data) async {
    String message = await firebaseService.addAppointment(data);
    notifyListeners();
    return message;
  }

  Future<String> editAppointment(
      String id, Map<String, dynamic> updatedData) async {
    String message = await firebaseService.editAppointment(id, updatedData);
    notifyListeners();
    return message;
  }

  Future<String> deleteAppointment(Map<String, dynamic> data) async {
    String message = await firebaseService.deleteAppointment(data);
    notifyListeners();
    return message;
  }
}
