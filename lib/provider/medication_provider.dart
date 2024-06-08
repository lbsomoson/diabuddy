import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/api/medication_api.dart';
import 'package:flutter/material.dart';

class MedicationProvider with ChangeNotifier {
  FirebaseMedicationAPI firebaseService = FirebaseMedicationAPI();

  late Stream<QuerySnapshot> _medicationsStream;

  Stream<QuerySnapshot> getMedications(String id) {
    _medicationsStream = firebaseService.getMedications(id);
    notifyListeners();
    return _medicationsStream;
  }

  Future<Map<String, dynamic>> getMedication(String id) async {
    Map<String, dynamic> medication = await firebaseService.getMedication(id);
    notifyListeners();
    return medication;
  }

  Future<String> addMedication(Map<String, dynamic> data) async {
    String message = await firebaseService.addMedication(data);
    notifyListeners();
    return message;
  }

  Future<String> editMedication(
      String id, Map<String, dynamic> updatedData) async {
    String message = await firebaseService.editMedication(id, updatedData);
    notifyListeners();
    return message;
  }
}
