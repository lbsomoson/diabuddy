import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/daily_health_record_model.dart';

class RecordRepository {
  final FirebaseFirestore firestore;

  RecordRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addRecord(DailyHealthRecord record) {
    return firestore.collection('records').add(record.toJson(record));
  }

  Future<void> updateRecord(DailyHealthRecord record, String recordId) async {
    try {
      // retrieve the document
      DocumentSnapshot documentSnapshot = await firestore.collection('records').doc(recordId).get();

      // check if the document exists
      if (documentSnapshot.exists) {
        // exclude the field that will not be updated from the existing data
        Map<String, dynamic> existingData = documentSnapshot.data() as Map<String, dynamic>;

        // merge the updated data with the existing data
        Map<String, dynamic> updatedData = record.toJson(record);
        Map<String, dynamic> mergedData = {...existingData, ...updatedData};

        // update the document with the merged data
        await firestore.collection('records').doc(recordId).set(mergedData);
      }
    } on FirebaseException catch (e) {
      print("Error in ${e.code}: ${e.message}");
    }
  }

  Future<void> deleteRecord(String recordId) {
    return firestore.collection('records').doc(recordId).delete();
  }

  Stream<List<DailyHealthRecord>> getRecords(String userId) {
    return FirebaseFirestore.instance
        .collection('records')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // include the document ID when creating the DailyHealthRecord object
        return DailyHealthRecord.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
