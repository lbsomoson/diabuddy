import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMedicationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // get ALL medications
  Stream<QuerySnapshot> getMedications(String id) {
    return db
        .collection('medications')
        .where("userId", isEqualTo: id)
        .where("isActive", isEqualTo: true)
        .snapshots();
  }

  // get ONE medication by id
  Future<Map<String, dynamic>> getMedication(String id) async {
    DocumentSnapshot m = await db.collection("medications").doc(id).get();
    Map<String, dynamic> medication = m.data() as Map<String, dynamic>;

    return medication;
  }

  // add a new medication
  Future<String> addMedication(Map<String, dynamic> data) async {
    try {
      await db.collection('medications').add(data);
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // edit a medication details
  Future<String> editMedication(
      String id, Map<String, dynamic> updatedData) async {
    try {
      // retrieve the document
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
    }
  }

  // delete medication
  Future<String> deleteMedication(Map<String, dynamic> data) async {
    try {
      await db
          .collection('medications')
          .doc(data['medicationId'])
          .update({'isActive': false});
      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
