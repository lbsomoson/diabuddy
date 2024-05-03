import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [
    "Inumin ang <Pangalan ng gamot>",
    "Inumin ang <Pangalan ng gamot>",
    "Kumain ng tanghalian",
    "Pumunta sa medikal na appointment",
    "Inumin ang <Pangalan ng gamot>",
    "Inumin ang <Pangalan ng gamot>",
  ];

  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now();

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                      text: "Notification Screen", style: 'bodyLarge'),
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/notificationSettingsScreen');
                    },
                  ),
                ],
              ),
              Column(
                children: notifications.map((notification) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set border radius as needed
                        side: BorderSide(
                            color: Colors.grey[300]!), // Set outline color
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.medical_services_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        trailing: Icon(
                          Icons.circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 15,
                        ),
                        title:
                            TextWidget(text: notification, style: 'bodyMedium'),
                        subtitle: const TextWidget(
                            text: "asdfadsf", style: 'bodySmall'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
