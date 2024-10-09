// import 'dart:convert';

// class LocalNotifications {}

import 'package:diabuddy/models/notification_model.dart';
import 'package:diabuddy/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<List<Map<String, dynamic>>> notificationList;
  late Future<int> channelIdFuture;
  late int currentChannelId;

  LocalNotifications() {
    // _initializeChannelId();
  }

  // // Initialize currentChannelId
  // Future<void> _initializeChannelId() async {
  //   currentChannelId = await _getChannelId();
  // }

  // // Method to get the channelId from SharedPreferences
  // Future<int> _getChannelId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('channelIdFuture') ?? 1;
  // }

  // // Method to set the channelId in SharedPreferences
  // Future<void> _setChannelId(int channelId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('channelIdFuture', channelId);
  // }

  // // Method to increment the channelId and save it to SharedPreferences
  // Future<void> incrementChannelId() async {
  //   currentChannelId += 1;
  //   await _setChannelId(currentChannelId);
  // }

  // Function to get the list of maps from shared preferences
  // Future<List<Map<String, dynamic>>> getNotificationList() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonString = prefs.getString('notificationList');
  //   if (jsonString != null) {
  //     List<dynamic> decoded = jsonDecode(jsonString);
  //     return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  //   } else {
  //     return [];
  //   }
  // }

  // // Function to add a map to the list of maps in shared preferences
  // Future<void> addNotificationToPreferences(
  //     Map<String, dynamic> newNotification) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<Map<String, dynamic>> notificationList = await getNotificationList();
  //   notificationList.add(newNotification);
  //   String jsonString = jsonEncode(notificationList);
  //   await prefs.setString('notificationList', jsonString);
  // }

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse response) {
    onClickNotification.add(response.payload!);
  }

  static Future initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: ((id, title, body, payload) =>
                null));
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static Future cancel(int channelId) async {
    await _flutterLocalNotificationsPlugin.cancel(channelId);
  }

  Future<void> showScheduledNotification(BuildContext context,
      {required String id,
      required String medicationId,
      required String title,
      required String body,
      required List<String> time,
      required String payload}) async {
    final bool isPermissionGranted = await Permission.notification.isGranted;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> newNotification = {
      'userId': id,
      'title': title,
      'body': body,
      'payload': payload,
      'time': time,
      'channelId': currentChannelId,
    };

    // await addNotificationToPreferences(newNotification);

    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        print('Notification permission is still not granted.');
        return;
      }
    }

    // List<Map<String, dynamic>> updatedNotificationList =
    // await getNotificationList();
    // print("updatedNotificationList::::: $updatedNotificationList");

    final philippinesTimeZone = tz.getLocation('Asia/Manila');
    final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);
    final scheduledTime = philippinesTime.add(const Duration(seconds: 5));

    print("====== SCHEDULED TIME: $scheduledTime");
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        0, // medicationId
        title,
        body,
        scheduledTime,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);

    final repeatNotificationDetails = NotificationDetails(
      android: AndroidNotificationDetails('channel 3', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
    );

    // TODO: get the frequency of the medication
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0, // medicationId,
      title,
      body,
      RepeatInterval.daily,
      repeatNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
    // await incrementChannelId();

    NotificationModel scheduledNotification = NotificationModel(
        userId: id, title: title, body: body, time: scheduledTime);

    if (context.mounted) {
      String res = await context
          .read<NotificationProvider>()
          .addNotification(scheduledNotification.toJson(scheduledNotification));
      print("----------------------------$res");
    }
  }

  Future<void> showScheduledNotificationAppointment(BuildContext context,
      {required String id,
      required String appointmentId,
      required String title,
      required String body,
      required DateTime date,
      required String payload}) async {
    final bool isPermissionGranted = await Permission.notification.isGranted;

    Map<String, dynamic> newNotification = {
      'userId': id,
      'title': title,
      'body': body,
      'payload': payload,
      'channelId': currentChannelId,
    };

    // await addNotificationToPreferences(newNotification);

    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        print('Notification permission is still not granted.');
        return;
      }
    }

    // List<Map<String, dynamic>> updatedNotificationList =
    // await getNotificationList();
    // print("updatedNotificationList::::: $updatedNotificationList");

    final philippinesTimeZone = tz.getLocation('Asia/Manila');
    final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);
    final scheduledTime = philippinesTime.add(const Duration(seconds: 5));

    print("====== SCHEDULED TIME: $scheduledTime");
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        1, // appointmentId,
        title,
        body,
        scheduledTime,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'channel 3', 'your channel name',
                channelDescription: 'your channel description',
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);

    final repeatNotificationDetails = NotificationDetails(
      android: AndroidNotificationDetails('channel 3', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      currentChannelId,
      title,
      body,
      RepeatInterval.daily,
      repeatNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );

    // await incrementChannelId();

    NotificationModel scheduledNotification = NotificationModel(
        userId: id, title: title, body: body, time: scheduledTime);

    if (context.mounted) {
      await context
          .read<NotificationProvider>()
          .addNotification(scheduledNotification.toJson(scheduledNotification));
    }
  }
}
