import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabuddy/api/notification_api.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  FirebaseNotificationAPI firebaseService = FirebaseNotificationAPI();

  late Stream<QuerySnapshot> _notificationsStream;

  Stream<QuerySnapshot> getNotifications(String id) {
    _notificationsStream = firebaseService.getNotifications(id);
    notifyListeners();
    return _notificationsStream;
  }

  Future<String> addNotification(Map<String, dynamic> data) async {
    String message = await firebaseService.addNotification(data);
    notifyListeners();
    return message;
  }

  Future<String> editNotification(
      String id, Map<String, dynamic> updatedData) async {
    String message = await firebaseService.editNotification(id, updatedData);
    notifyListeners();
    return message;
  }
}
