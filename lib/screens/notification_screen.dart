import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/notification_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diabuddy/models/notification_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  User? user;
  // static int count = 0;

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
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
            children: [_displayNotifications(context, user!.uid)],
          ),
        ),
      ),
    ));
  }
}

String getTimePassed(String dateString) {
  print(dateString);

  // Parse the date string
  final DateTime dateTime = DateTime.parse(dateString);

  // Get the current time
  final DateTime now = DateTime.now();

  // Calculate the difference
  final Duration difference = now.difference(dateTime);

  // Format the difference into a readable format
  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return '${difference.inSeconds} second${difference.inSeconds > 1 ? 's' : ''} ago';
  }
}

// bool checkTimeString(String timeString) {
//   // Split the string into words
//   List<String> words = timeString.split(' ');

//   // Check if the first word is "0" and the second word is "seconds"
//   if (words.length > 1 && words[0] == "0" && words[1] == "seconds") {
//     return true;
//   }

//   return false;
// }

Widget _displayNotifications(BuildContext context, String id) {
  var timePassed;
  // bool result;

  return StreamBuilder(
      stream: context.watch<NotificationProvider>().getNotifications(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error encountered! ${snapshot.error}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text("No Notification Found"),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text2Widget(text: "No notifications yet", style: 'body2'))]),
          ));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              NotificationModel notification =
                  NotificationModel.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
              notification.notificationId = snapshot.data?.docs[index].id;
              timePassed = getTimePassed(notification.time.toString());
              // result = checkTimeString(timePassed);
              return CardWidget(
                trailing: Icons.circle,
                leading: FontAwesomeIcons.pills,
                title: notification.body,
                subtitle: timePassed,
                size: 15,
              );
              // if (result == false) {
              // } else {
              //   return Container();
              // }
            });
      });
}
