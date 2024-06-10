import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseNotificationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  // get ALL notifications
  Stream<QuerySnapshot> getNotifications(String id) {
    return db
        .collection('notifications')
        .where("userId", isEqualTo: id)
        .where("time", isLessThanOrEqualTo: DateTime.now())
        .orderBy("time", descending: true)
        .snapshots();
  }

  // add a new notification
  Future<String> addNotification(Map<String, dynamic> data) async {
    try {
      await db.collection('notifications').add(data);
      print("Successfully added!");
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  // edit a notification details
  Future<String> editNotification(
      String id, Map<String, dynamic> updatedData) async {
    try {
      // retrieve the document
      DocumentSnapshot documentSnapshot =
          await db.collection('notifications').doc(id).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be update from the existing data
        Map<String, dynamic> existingData =
            documentSnapshot.data() as Map<String, dynamic>;
        existingData.remove('title'); // remove the field to exclude

        // merge the updated data with the existing data
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await FirebaseFirestore.instance
            .collection('notifications')
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
}
