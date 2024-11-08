import 'dart:core';

import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:diabuddy/widgets/local_notifications.dart';

import 'package:diabuddy/utils/text_to_speech.dart';

class VerifySubmit extends StatefulWidget {
  final MedicationIntake medicationIntake;
  const VerifySubmit({super.key, required this.medicationIntake});

  @override
  State<VerifySubmit> createState() => _VerifySubmitState();
}

class _VerifySubmitState extends State<VerifySubmit> {
  String? userId;
  LocalNotifications localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    listenToNotification();

    Future.delayed(Duration.zero, () {
      userId = context.read<UserAuthProvider>().user?.uid;
    });
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    print("=======================================Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification clicked");
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(style: 'bodyLarge', text: "Verify Submit"),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.medicationIntake.name),
              Text(widget.medicationIntake.dose),
              // Text(widget.medicationIntake.time),
              Column(
                children: List.generate(
                  widget.medicationIntake.time.length,
                  (index) => Column(
                    children: [
                      Text(
                        widget.medicationIntake.time[index],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ).toList(),
              ),
              Text(widget.medicationIntake.frequency),
              TextFieldWidget(
                initialValue:
                    widget.medicationIntake.verifiedBy?['licenseNo'] ?? '',
                callback: (String val) {
                  setState(() {
                    widget.medicationIntake.verifiedBy?['licenseNo'] = val;
                  });
                },
                hintText: 'License Numnber',
                label: 'License Numnber',
                type: 'String',
              ),
              TextFieldWidget(
                initialValue:
                    widget.medicationIntake.verifiedBy?['ptrNo'] ?? '',
                callback: (String val) {
                  setState(() {
                    widget.medicationIntake.verifiedBy?['ptrNo'] = val;
                  });
                },
                hintText: 'PTR Numnber',
                label: 'PTR Numnber',
                type: 'String',
              ),
              ButtonWidget(
                  callback: () async {
                    TextToSpeechService().dispose();
                    TextToSpeechService().speak(
                        "Oras na para inumin ang ${widget.medicationIntake.name}!");
                    TextToSpeechService().dispose();

                    context
                        .read<MedicationBloc>()
                        .add(AddMedication(widget.medicationIntake));

                    if (context.mounted) {
                      final snackBar = SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: const Text('Added medication successfully!'),
                        action:
                            SnackBarAction(label: 'Close', onPressed: () {}),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      await localNotifications.showScheduledNotification(
                          context,
                          id: widget.medicationIntake.userId,
                          medicationId: widget.medicationIntake.channelId,
                          title: "Medication Reminder",
                          time: widget.medicationIntake.time,
                          frequency: widget.medicationIntake.frequency,
                          body:
                              "Time to take your ${widget.medicationIntake.name}!",
                          payload: "Medication Reminder");
                    }

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(context, '/profileScreen',
                        (Route<dynamic> route) => false);
                  },
                  label: 'Submit Medication',
                  style: 'filled')
            ],
          ),
        )));
  }
}
