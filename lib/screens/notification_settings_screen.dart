import 'package:diabuddy/widgets/switch.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const TextWidget(
                  text: "Notification Screen", style: 'bodyLarge'),
            ),
            body: const Column(
              children: [
                ListTile(
                  trailing: SwitchWidget(),
                  title: TextWidget(
                      text: "Voice Notification Reminder", style: 'bodyMedium'),
                ),
                ListTile(
                  trailing: SwitchWidget(),
                  title: TextWidget(
                      text: "Meal Logging Notification Reminder",
                      style: 'bodyMedium'),
                ),
              ],
            )));
  }
}
