import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/services/database_service.dart';
import 'package:flutter/material.dart';

class DailyHealthRecordProvider with ChangeNotifier {
  final DatabaseService databaseService = DatabaseService();

  late DailyHealthRecord? record;
  late List<DailyHealthRecord> records;

  Future<void> addRecord(DailyHealthRecord record) async {
    try {
      await databaseService.insertRecord(record);
      notifyListeners(); // Notify UI that data has changed
    } catch (e) {
      print("Error adding meal intake: $e");
    }
  }

  Future<DailyHealthRecord?> getRecordByDate(String userId, DateTime date) async {
    record = await databaseService.getRecordByDate(userId, date);
    return record;
  }

  Future<void> updateRecord(DailyHealthRecord record) async {
    try {
      await databaseService.updateRecord(record);
      notifyListeners();
    } catch (e) {
      print("Error updating record: $e");
    }
  }

  Future<List<DailyHealthRecord>> getRecordsPerMonth(String userId, DateTime date) async {
    records = await databaseService.getRecordsPerMonth(userId, date);
    return records;
  }
}
