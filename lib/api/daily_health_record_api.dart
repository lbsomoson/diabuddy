import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDailyHealthRecordAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDailyHealthRecord(Map<String, dynamic> data) async {
    try {
      await db.collection('daily_health_records').add(data);
      return "Successfully added!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }
}
