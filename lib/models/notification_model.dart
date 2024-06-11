import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? notificationId;
  final String userId;
  final String title;
  final String body;
  final DateTime time;

  NotificationModel({
    this.notificationId,
    required this.userId,
    required this.title,
    required this.body,
    required this.time,
  });

  // Factory constructor to instantiate object from json format
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'] as String?,
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      time: (json['time'] as Timestamp).toDate(),
    );
  }

  static List<NotificationModel> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data
        .map<NotificationModel>((dynamic d) => NotificationModel.fromJson(d))
        .toList();
  }

  Map<String, dynamic> toJson(NotificationModel notification) {
    return {
      'notificationId': notification.notificationId,
      'userId': notification.userId,
      'title': notification.title,
      'body': notification.body,
      'time': notification.time,
    };
  }
}
