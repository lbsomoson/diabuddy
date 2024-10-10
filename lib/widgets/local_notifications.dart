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
import 'package:flutter_timezone/flutter_timezone.dart';

class LocalNotifications {
  late Future<List<Map<String, dynamic>>> notificationList;
  late Future<int> channelIdFuture;
  late int currentChannelId;

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
            onDidReceiveLocalNotification: ((id, title, body, payload) => {}));
    const LinuxInitializationSettings initializationSettingsLinux =
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

  // Future<void> showScheduledNotification(BuildContext context,
  //     {required String id,
  //     required int medicationId,
  //     required String title,
  //     required String body,
  //     required List<String> time,
  //     required String payload}) async {
  //   final bool isPermissionGranted = await Permission.notification.isGranted;

  //   if (!isPermissionGranted) {
  //     await Permission.notification.request();
  //     if (await Permission.notification.isDenied) {
  //       print('Notification permission is still not granted.');
  //       return;
  //     }
  //   }

  //   final philippinesTimeZone = tz.getLocation('Asia/Manila');
  //   final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);
  //   final scheduledTime = philippinesTime.add(const Duration(seconds: 5));

  //   print("====== SCHEDULED TIME: $scheduledTime");
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //       medicationId,
  //       title,
  //       body,
  //       scheduledTime,
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'channel 3', 'your channel name',
  //               channelDescription: 'your channel description',
  //               importance: Importance.max,
  //               priority: Priority.high,
  //               ticker: 'ticker')),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       payload: payload);

  //   const repeatNotificationDetails = NotificationDetails(
  //     android: AndroidNotificationDetails('channel 3', 'your channel name',
  //         channelDescription: 'your channel description',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         ticker: 'ticker'),
  //   );

  //   // TODO: get the frequency of the medication
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //     medicationId,
  //     title,
  //     body,
  //     RepeatInterval.daily,
  //     repeatNotificationDetails,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     payload: payload,
  //   );
  // }

//   Future<void> showScheduledNotification(BuildContext context, {
//   required String id,
//   required int medicationId,
//   required String title,
//   required String body,
//   required List<String> time,  // List of times (in string format)
//   required String payload
// }) async {
//   final bool isPermissionGranted = await Permission.notification.isGranted;

//   if (!isPermissionGranted) {
//     await Permission.notification.request();
//     if (await Permission.notification.isDenied) {
//       print('Notification permission is still not granted.');
//       return;
//     }
//   }

//   final philippinesTimeZone = tz.getLocation('Asia/Manila');
//   final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);

//   for (String timeString in time) {
//     // Step 1: Parse the time string (assuming format "HH:mm")
//     List<String> timeParts = timeString.split(':');
//     int hour = int.parse(timeParts[0]);
//     int minute = int.parse(timeParts[1]);

//     // Step 2: Create a DateTime with today's date and the parsed time
//     DateTime dateTime = DateTime(philippinesTime.year, philippinesTime.month, philippinesTime.day, hour, minute);

//     // Step 3: Convert DateTime to TZDateTime
//     tz.TZDateTime scheduledTime = tz.TZDateTime.from(dateTime, philippinesTimeZone);

//     // Step 4: Schedule the notification
//     print("Scheduling notification for: $scheduledTime");
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       medicationId,
//       title,
//       body,
//       scheduledTime,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channel 3',
//           'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//     );
//   }

//   const repeatNotificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails('channel 3', 'your channel name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker'),
//   );

//   // TODO: Get the frequency of the medication
//   await _flutterLocalNotificationsPlugin.periodicallyShow(
//     medicationId,
//     title,
//     body,
//     RepeatInterval.daily,
//     repeatNotificationDetails,
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     payload: payload,
//   );
// }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print("scheduled date: $scheduledDate");
    return scheduledDate;
  }

  Future<void> showScheduledNotification(
    BuildContext context, {
    required String id,
    required int medicationId,
    required String title,
    required String body,
    required List<String> time,
    required String frequency, // 'None' or 'Everyday'
    required String payload,
  }) async {
    final bool isPermissionGranted = await Permission.notification.isGranted;

    // Check if notification permission is granted
    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        print('Notification permission is still not granted.');
        return;
      }
    }

    for (String timeString in time) {
      // Parse the time string (assuming format "hh:mm AM/PM")
      List<String> timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0].trim());
      int minute = int.parse(timeParts[1]
          .substring(0, 2)
          .trim()); // Get minute part (first two chars)
      String amPm = timeString
          .substring(timeString.length - 2)
          .toUpperCase(); // Get AM/PM

      // Adjust hour based on AM/PM
      if (amPm == 'AM' && hour == 12) {
        hour = 0; // 12 AM is midnight, so set hour to 0
      } else if (amPm == 'PM' && hour != 12) {
        hour += 12; // Convert PM hours to 24-hour format
      }

      print("time == hour: $hour, minute $minute");

      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      print("timezone: ${tz.local}");

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        medicationId,
        title,
        body,
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "channel 3",
            'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    }

    // If frequency is "Everyday", schedule the notification to repeat daily
    if (frequency == "Everyday") {
      const repeatNotificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 3',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      );
      await _flutterLocalNotificationsPlugin.periodicallyShow(
        medicationId,
        title,
        body,
        RepeatInterval.daily,
        repeatNotificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
      );
    }
  }

  Future<void> showScheduledNotificationAppointment(BuildContext context,
      {required String id,
      required int appointmentId,
      required String title,
      required String body,
      required DateTime date,
      required String payload}) async {
    final bool isPermissionGranted = await Permission.notification.isGranted;

    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        print('Notification permission is still not granted.');
        return;
      }
    }

    final philippinesTimeZone = tz.getLocation('Asia/Manila');
    final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);
    final scheduledTime = philippinesTime.add(const Duration(seconds: 5));

    print("======== SCHEDULED TIME: $scheduledTime");
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        appointmentId,
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

    const repeatNotificationDetails = NotificationDetails(
      android: AndroidNotificationDetails('channel 3', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      appointmentId,
      title,
      body,
      RepeatInterval.daily,
      repeatNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
  }
}
