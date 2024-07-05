import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/medication_intake_model.dart';

class MedicationRepository {
  final FirebaseFirestore firestore;

  MedicationRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addMedication(MedicationIntake medication) {
    return firestore
        .collection('medications')
        .doc(medication.medicationId)
        .set(medication.toJson(medication));
  }

  Future<void> updateMedication(MedicationIntake medication) {
    return firestore
        .collection('medications')
        .doc(medication.medicationId)
        .update(medication.toJson(medication));
  }

  Future<void> deleteMedication(String medicationId) {
    return firestore.collection('medications').doc(medicationId).delete();
  }

  Stream<List<MedicationIntake>> getMedications(String userId) {
    return firestore
        .collection('medications')
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MedicationIntake.fromJson(doc.data()))
          .toList();
    });
  }
}
