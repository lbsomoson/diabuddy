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

  Future<void> updateMedication(
      MedicationIntake medication, String medicationId) async {
    try {
      // retrieve the document
      DocumentSnapshot documentSnapshot =
          await firestore.collection('medications').doc(medicationId).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be updated from the existing data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;
        existingData.remove('name'); // remove the field to exclude

        // merge the updated data with the existing data
        Map<String, dynamic> updatedData = medication.toJson(medication);
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await firestore
            .collection('medications')
            .doc(medicationId)
            .set(mergedData);
      }
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
  }

  Future<void> deleteMedication(String medicationId) {
    return firestore
        .collection('medications')
        .doc(medicationId)
        .update({'isActive': false});
  }

  Stream<List<MedicationIntake>> getMedications(String userId) {
    print(
        "===================Fetching medications for user: $userId===================");

    print("Fetching medications for user: $userId");
    return firestore
        .collection('medications')
        .where("userId", isEqualTo: userId)
        .where("isActive", isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      print("Medications snapshot: ${snapshot.docs.length} documents fetched.");
      return snapshot.docs
          .map((doc) => MedicationIntake.fromJson(doc.data()))
          .toList();
    });
  }
}
