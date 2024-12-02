import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/services/database_service.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  late List<Appointment> appointments;

  Future<List<Appointment>> getAppointments(String userId) async {
    appointments = await databaseService.getAppointments(userId);
    return appointments;
  }

  Future<void> addAppointment(Appointment appointment) async {
    try {
      await databaseService.insertAppointment(appointment);
      notifyListeners(); // Notify UI that data has changed
    } catch (e) {
      print("Error adding medication: $e");
    }
  }

  Future<void> updateAppointment(Appointment appointment, String appointmentId) async {
    try {
      await databaseService.updateAppointment(appointment, appointmentId);
      notifyListeners();
    } catch (e) {
      print("Error updating medication: $e");
    }
  }

  Future<void> deleteAppointment(int appointmentId) async {
    try {
      await databaseService.deleteAppointment(appointmentId);
      notifyListeners();
    } catch (e) {
      print("Error deleting medication: $e");
    }
  }
}
