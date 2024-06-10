import 'package:diabuddy/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse response) {
    onClickNotification.add(response.payload!);
  }

  static Future initialize() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
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

  Future showSimpleNotification(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future showScheduledNotification(BuildContext context,
      {required String id,
      required String title,
      required String body,
      required String payload}) async {
    // check if the permission is granted
    final bool isPermissionGranted = await Permission.notification.isGranted;

    if (!isPermissionGranted) {
      // request permission if not granted
      await Permission.notification.request();
      // check the permission status again
      if (await Permission.notification.isDenied) {
        // handle case when the permission is still not granted
        print('Notification permission is still not granted.');
        return;
      }
    }

    // Get the timezone for the Philippines
    final philippinesTimeZone = tz.getLocation('Asia/Manila');

    // Get the current time in the Philippines timezone
    final philippinesTime = tz.TZDateTime.now(philippinesTimeZone);

    // Add 5 seconds to the current time in the Philippines timezone
    final scheduledTime = philippinesTime.add(const Duration(seconds: 30));

    print(scheduledTime);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        2,
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

    // Schedule repeating notifications
    final repeatNotificationDetails = NotificationDetails(
      android: AndroidNotificationDetails('channel 3', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
    );

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      3,
      title,
      body,
      RepeatInterval.daily,
      repeatNotificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );

    if (context.mounted) {
      await context.read<NotificationProvider>().addNotification({
        'userId': id,
        'title': title,
        'body': body,
        'payload': payload,
        'time': scheduledTime.toString(),
      });
    }

    // Cancel the scheduled notification
    // await _flutterLocalNotificationsPlugin.cancel(2);
    // await _flutterLocalNotificationsPlugin.cancel(3);
  }
}
