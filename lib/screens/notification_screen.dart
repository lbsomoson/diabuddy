import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [
    "Pumunta sa medikal na appointment",
    "Inumin ang <Pangalan ng gamot>",
    "Pumunta sa medikal na appointment",
    "Inumin ang <Pangalan ng gamot>",
    "Pumunta sa medikal na appointment",
    "Pumunta sa medikal na appointment",
    "Kumain ng tanghalian",
    "Pumunta sa medikal na appointment",
    "Pumunta sa medikal na appointment",
    "Pumunta sa medikal na appointment",
    "Pumunta sa medikal na appointment",
    "Inumin ang <Pangalan ng gamot>",
    "Inumin ang <Pangalan ng gamot>",
  ];

  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Notification Screen"),
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.pushNamed(context, '/notificationSettingsScreen');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Column(
                children: notifications.map((notification) {
                  return CardWidget(
                    trailing: Icons.circle,
                    leading: FontAwesomeIcons.pills,
                    title: notification,
                    subtitle: "asdfadsf",
                    size: 15,
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
