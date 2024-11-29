import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/models/daily_health_record_model.dart';

class RecordRepository {
  final FirebaseFirestore firestore;

  RecordRepository({FirebaseFirestore? firestore}) : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addRecord(DailyHealthRecord record) async {
    try {
      // define the start and end of the day for the record's timestamp
      DateTime startOfDay = DateTime(record.date.year, record.date.month, record.date.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      // check if a record with the same `userId` and `date` already exists
      QuerySnapshot existingRecord = await firestore
          .collection('records')
          .where('userId', isEqualTo: record.userId)
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThan: endOfDay)
          .limit(1)
          .get();

      if (existingRecord.docs.isNotEmpty) {
        // if a record exists, do nothing and return
        print('Record already exists for this user on the specified date.');
        return;
      }

      // add the new record if no duplicate exists
      await firestore.collection('records').add(record.toJson(record));
      print('Record added successfully.');
    } catch (e) {
      print('Error adding record: $e');
    }
  }

  Future<void> updateRecord(DailyHealthRecord record) async {
    try {
      // Define the start and end of the day for the record's date
      DateTime startOfDay = DateTime(record.date.year, record.date.month, record.date.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      // Query for the existing record with the same `userId` and date range
      QuerySnapshot existingRecord = await firestore
          .collection('records')
          .where('userId', isEqualTo: record.userId)
          .where('date', isGreaterThanOrEqualTo: startOfDay)
          .where('date', isLessThan: endOfDay)
          .limit(1)
          .get();

      if (existingRecord.docs.isNotEmpty) {
        // get the first matching document's ID
        String documentId = existingRecord.docs.first.id;

        // convert the existing document data to a Map
        Map<String, dynamic> existingData = existingRecord.docs.first.data() as Map<String, dynamic>;
        existingData.remove('date');
        existingData.remove('recordId');
        existingData.remove('stepCount');

        // merge the existing data with the new data from `record`
        Map<String, dynamic> updatedData = {
          ...existingData,
          ...record.toJson(record),
          'healthyEatingIndex': existingData['healthyEatingIndex'] + record.healthyEatingIndex,
          'glycemicIndex': existingData['glycemicIndex'] + record.glycemicIndex,
          'carbohydrates': existingData['carbohydrates'] + record.carbohydrates,
          'energyKcal': existingData['energyKcal'] + record.energyKcal,
          'diversityScore': existingData['diversityScore'] + record.diversityScore,
        };

        // Update the document with the merged data
        await firestore.collection('records').doc(documentId).set(updatedData);

        print('Record updated successfully.');
      } else {
        // Handle the case where no matching document exists
        print('No existing record found for the specified date and userId.');
      }
    } on FirebaseException catch (e) {
      // handle Firestore-specific exceptions
      print("FirebaseException: ${e.message}");
    } catch (e) {
      // handle other types of exceptions
      print("An error occurred: $e");
    }
  }

  Future<void> deleteRecord(String recordId) {
    return firestore.collection('records').doc(recordId).delete();
  }

  Stream<List<DailyHealthRecord>> getRecords(String userId, DateTime date) {
    // final r =
    //     FirebaseFirestore.instance.collection('records').where("userId", isEqualTo: userId).snapshots().map((snapshot) {
    //   return snapshot.docs.map((doc) {
    //     return DailyHealthRecord.fromJson(doc.data(), doc.id);
    //   }).toList();
    // });
    // return r;
    return FirebaseFirestore.instance
        .collection('records')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return DailyHealthRecord.fromJson(doc.data(), doc.id);
      }).toList();
    }).map((records) {
      // return records.where((record) {
      //   final recordDate = record.date; // Assuming `date` is a field in DailyHealthRecord
      //   return recordDate.year == date.year && recordDate.month == date.month;
      // }).toList();

      // Filter records by the specified month and year
      // final filteredRecords = records.where((record) {
      //   final recordDate = record.date; // Assuming `date` is a field in DailyHealthRecord
      //   return recordDate.year == date.year && recordDate.month == date.month;
      // }).toList();

      // // Sort the filtered records in descending order of date
      // filteredRecords.sort((a, b) => b.date.compareTo(a.date));
      // return filteredRecords;

      // Filter records by the specified month and year
      final filteredRecords = records.where((record) {
        final recordDate = record.date; // Assuming `date` is a field in DailyHealthRecord
        return recordDate.year == date.year && recordDate.month == date.month;
      }).toList();

      // Sort the filtered records in ascending order of date
      filteredRecords.sort((a, b) => a.date.compareTo(b.date));
      return filteredRecords;
    });
  }

  // get one record
  Future<DailyHealthRecord?> getRecordByDate(String id, DateTime date) async {
    try {
      // calculate the start and end of the specified date
      DateTime startOfDay = DateTime(date.year, date.month, date.day);
      DateTime endOfDay = startOfDay.add(const Duration(days: 1));

      // query Firestore for records that match the criteria
      QuerySnapshot querySnapshot = await firestore
          .collection("records")
          .where("userId", isEqualTo: id)
          .where("date", isGreaterThanOrEqualTo: startOfDay)
          .where("date", isLessThan: endOfDay)
          .get();

      // check if at least one document was returned
      if (querySnapshot.docs.isNotEmpty) {
        // access the first document in the result and map it to a Record object
        DocumentSnapshot recordSnapshot = querySnapshot.docs.first;
        DailyHealthRecord record = DailyHealthRecord.fromJson(recordSnapshot.data() as Map<String, dynamic>, id);
        return record;
      } else {
        // return null if no record was found
        return null;
      }
    } catch (e) {
      // handle any errors that occur during the query
      print("Error fetching record: $e");
      return null;
    }
  }
}
