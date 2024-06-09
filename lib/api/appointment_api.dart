import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAppointmentAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // get ALL appointments
  Stream<QuerySnapshot> getAppointments(String id) {
    return db
        .collection('appointments')
        .where("userId", isEqualTo: id)
        .snapshots();
  }

  // get ONE appointment by id
  Future<Map<String, dynamic>> getAppointment(String id) async {
    DocumentSnapshot m = await db.collection("appointments").doc(id).get();
    Map<String, dynamic> appointment = m.data() as Map<String, dynamic>;

    return appointment;
  }

  // add a new appointment
  Future<String> addAppointment(Map<String, dynamic> data) async {
    try {
      await db.collection('appointments').add(data);
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // edit a appointment details
  Future<String> editAppointment(
      String id, Map<String, dynamic> updatedData) async {
    try {
      // retrieve the document
      DocumentSnapshot documentSnapshot =
          await db.collection('appointments').doc(id).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be update from the existing data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;

        // merge the updated data with the existing data
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await FirebaseFirestore.instance
            .collection('appointments')
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

  // delete appointment
  Future<String> deleteAppointment() async {
    try {
      await db.collection('appointments').doc().delete();
      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
