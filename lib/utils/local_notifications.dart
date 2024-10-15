import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
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

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
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

    // check if notification permission is granted
    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        // print('Notification permission is still not granted.');
        return;
      }
    }

    // schedule notifications for each time string in the list
    for (int i = 0; i < time.length; i++) {
      String timeString = time[i];

      // parse the time string (assuming format "hh:mm AM/PM")
      List<String> timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0].trim());
      int minute = int.parse(timeParts[1]
          .substring(0, 2)
          .trim()); // Get minute part (first two chars)
      String amPm = timeString
          .substring(timeString.length - 2)
          .toUpperCase(); // Get AM/PM

      // adjust hour based on AM/PM
      if (amPm == 'AM' && hour == 12) {
        hour = 0; // 12 AM is midnight, so set hour to 0
      } else if (amPm == 'PM' && hour != 12) {
        hour += 12; // Convert PM hours to 24-hour format
      }

      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));

      // schedule the notification at the specific time
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        medicationId + i, // unique notification ID
        title,
        body,
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            "medicationId",
            'title',
            channelDescription: 'body',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            frequency == 'Everyday' ? DateTimeComponents.time : null,
        payload: payload,
      );
    }
  }

  Future<void> updateScheduledNotification(
    BuildContext context, {
    required int medicationId,
    required String title,
    required String body,
    required List<String> time,
    required String frequency,
    required String payload,
  }) async {
    // cancel all existing notifications with the given medicationId (and potentially multiple)
    for (int i = 0; i < time.length; i++) {
      await _flutterLocalNotificationsPlugin.cancel(medicationId + i);
    }

    // reschedule the notification with the new details
    for (int i = 0; i < time.length; i++) {
      String timeString = time[i];

      // parse the time string (assuming format "hh:mm AM/PM")
      List<String> timeParts = timeString.split(':');
      int hour = int.parse(timeParts[0].trim());
      int minute =
          int.parse(timeParts[1].substring(0, 2).trim()); // Get minute part
      String amPm = timeString
          .substring(timeString.length - 2)
          .toUpperCase(); // Get AM/PM

      // adjust hour based on AM/PM
      if (amPm == 'AM' && hour == 12) {
        hour = 0; // 12 AM is midnight, so set hour to 0
      } else if (amPm == 'PM' && hour != 12) {
        hour += 12; // Convert PM hours to 24-hour format
      }

      final timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));

      // schedule the updated notification
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        medicationId + i,
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
        matchDateTimeComponents:
            frequency == 'Everyday' ? DateTimeComponents.time : null,
        payload: payload,
      );
    }
  }

  Future<void> cancelScheduledNotifications({
    required int medicationId,
    required List<String> time,
  }) async {
    for (int i = 0; i < time.length; i++) {
      // cancel each notification using the same unique ID pattern (medicationId + i)
      await _flutterLocalNotificationsPlugin.cancel(medicationId + i);
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
        // print('Notification permission is still not granted.');
        return;
      }
    }

    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        appointmentId,
        title,
        body,
        tz.TZDateTime(
            tz.local, date.year, date.month, date.day, date.hour, date.minute),
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
  }

  Future<void> updateScheduledNotificationAppointment(BuildContext context,
      {required String id,
      required int appointmentId,
      required String title,
      required String body,
      required DateTime date,
      required String payload}) async {
    final bool isPermissionGranted = await Permission.notification.isGranted;

    await _flutterLocalNotificationsPlugin.cancel(appointmentId);

    if (!isPermissionGranted) {
      await Permission.notification.request();
      if (await Permission.notification.isDenied) {
        // print('Notification permission is still not granted.');
        return;
      }
    }

    final timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        appointmentId,
        title,
        body,
        tz.TZDateTime(
            tz.local, date.year, date.month, date.day, date.hour, date.minute),
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
  }

  Future<void> cancelScheduledNotificationsAppointments({
    required int appointmentId,
  }) async {
    await _flutterLocalNotificationsPlugin.cancel(appointmentId);
  }
}
