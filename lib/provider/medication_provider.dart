import 'package:diabuddy/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:diabuddy/models/medication_intake_model.dart';

class MedicationProvider with ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  late List<MedicationIntake> medications;
  late List<MedicationIntake> inactiveMedications;

  Future<List<MedicationIntake>> getMedications(String userId) async {
    medications = await databaseService.getMedications(userId);
    return medications;
  }

  Future<List<MedicationIntake>> getInactiveMedications(String userId) async {
    inactiveMedications = await databaseService.getInactiveMedications(userId);
    return inactiveMedications;
  }

  Future<void> addMedication(MedicationIntake medication) async {
    try {
      await databaseService.insertMedication(medication);
      notifyListeners(); // Notify UI that data has changed
    } catch (e) {
      print("Error adding medication: $e");
    }
  }

  Future<void> updateMedication(MedicationIntake medication, String medicationId) async {
    try {
      await databaseService.updateMedication(medication, medicationId);
      notifyListeners();
    } catch (e) {
      print("Error updating medication: $e");
    }
  }

  Future<void> deleteMedication(String medicationId) async {
    try {
      await databaseService.deleteMedication(medicationId);
      notifyListeners();
    } catch (e) {
      print("Error deleting medication: $e");
    }
  }
}
