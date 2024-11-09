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
import 'package:diabuddy/widgets/timepicker.dart';
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

    print(widget.medicationIntake.time);
  }

  var items = [
    'None',
    'Everyday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(
              style: 'bodyLarge', text: "Verify Medication Details"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldWidget(
                  initialValue: widget.medicationIntake.name,
                  callback: (String val) {
                    setState(() {
                      widget.medicationIntake.name = val;
                    });
                  },
                  hintText: "Medicine Name",
                  label: "Medicine Name",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue: widget.medicationIntake.dose,
                  callback: (String val) {
                    setState(() {
                      widget.medicationIntake.dose = val;
                    });
                  },
                  hintText: "Dosage",
                  label: "Dosage",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.medicationIntake.time.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 5.0);
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.medicationIntake.time.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TimePickerWidget(
                                  initialValue:
                                      widget.medicationIntake.time[index],
                                  callback: (String value) {
                                    setState(() {
                                      widget.medicationIntake.time[index] =
                                          value;
                                    });
                                  },
                                  hintText: "Time",
                                  label: index == 0 ? "Time" : null,
                                );
                              }),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextWidget(text: "Repeat", style: 'bodyMedium'),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: widget.medicationIntake.frequency,
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black)),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.medicationIntake.frequency = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue:
                      widget.medicationIntake.verifiedBy?['licenseNo'] ?? '',
                  callback: (String val) {
                    setState(() {
                      widget.medicationIntake.verifiedBy?['licenseNo'] = val;
                    });
                  },
                  hintText: 'License Number',
                  label: 'License Number',
                  type: 'String',
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue:
                      widget.medicationIntake.verifiedBy?['ptrNo'] ?? '',
                  callback: (String val) {
                    setState(() {
                      widget.medicationIntake.verifiedBy?['ptrNo'] = val;
                    });
                  },
                  hintText: 'PTR Number',
                  label: 'PTR Number',
                  type: 'String',
                ),
                const SizedBox(
                  height: 20,
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
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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

                      Navigator.pushNamedAndRemoveUntil(context,
                          '/profileScreen', (Route<dynamic> route) => false);
                    },
                    label: 'Submit Medication',
                    style: 'filled')
              ],
            ),
          ),
        )));
  }
}
