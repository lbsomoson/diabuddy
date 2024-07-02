import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMedicationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  FirebaseMedicationAPI() {
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  // get ALL medications
  Stream<QuerySnapshot> getMedications(String id) {
    try {
      db.disableNetwork();
      return db
          .collection('medications')
          .where("userId", isEqualTo: id)
          .where("isActive", isEqualTo: true)
          .snapshots();
    } on FirebaseException catch (e) {
      print("Error: $e");
      return const Stream.empty();
    } finally {
      db.enableNetwork();
    }
  }

  // get ONE medication by id
  Future getMedication(String id) async {
    try {
      await db.disableNetwork();
      DocumentSnapshot m = await db.collection("medications").doc(id).get();
      Map<String, dynamic> medication = m.data() as Map<String, dynamic>;
      return medication;
    } on FirebaseException catch (e) {
      print("Error: $e");
    } finally {
      await db.enableNetwork();
    }
  }

  // add a new medication
  Future<String> addMedication(Map<String, dynamic> data) async {
    try {
      await db.disableNetwork();
      await db.collection('medications').add(data);
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    } finally {
      await db.enableNetwork();
    }
  }

  // edit a medication details
  Future<String> editMedication(
      String id, Map<String, dynamic> updatedData) async {
    try {
      // retrieve the document
      await db.disableNetwork();
      DocumentSnapshot documentSnapshot =
          await db.collection('medications').doc(id).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be update from the existing data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;
        existingData.remove('name'); // remove the field to exclude

        // merge the updated data with the existing data
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await FirebaseFirestore.instance
            .collection('medications')
            .doc(id)
            .set(mergedData);
        return "Successfully edited!";
      } else {
        // if document does not exist
        return "Document with ID $id does not exist.";
      }
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    } finally {
      await db.enableNetwork();
    }
  }

  // delete medication
  Future<String> deleteMedication(Map<String, dynamic> data) async {
    try {
      await db.disableNetwork();
      await db
          .collection('medications')
          .doc(data['medicationId'])
          .update({'isActive': false});
      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    } finally {
      await db.enableNetwork();
    }
  }
}
