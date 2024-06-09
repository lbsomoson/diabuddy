import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:permission_handler/permission_handler.dart';
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

  static Future showScheduledNotification(
      {required String title,
      required String body,
      required String payload}) async {
    print(
        "=====================================Scheduling notification================================");

    // Check if the permission is granted
    final bool isPermissionGranted = await Permission.notification.isGranted;

    if (!isPermissionGranted) {
      // Request permission if not granted
      await Permission.notification.request();
      // Check the permission status again
      if (await Permission.notification.isDenied) {
        // Handle case when the permission is still not granted
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
    // id, title, body, scheduledDate, notificationDetails, uiLocalNotificationDateInterpretation
    // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5))
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
  }
}
