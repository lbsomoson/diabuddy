import 'package:diabuddy/api/daily_health_record_api.dart';
import 'package:flutter/material.dart';

class DailyHealthRecordProvider with ChangeNotifier {
  FirebaseDailyHealthRecordAPI firebaseService = FirebaseDailyHealthRecordAPI();

  Future<String> addDailyHealthRecord(Map<String, dynamic> data) async {
    String message = await firebaseService.addDailyHealthRecord(data);
    notifyListeners();
    return message;
  }
}
