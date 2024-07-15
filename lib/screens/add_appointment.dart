import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/provider/appointment_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/datepicker.dart';
import 'package:diabuddy/widgets/local_notifications.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAppointmentScreen extends StatefulWidget {
  final String id;
  const AddAppointmentScreen({required this.id, super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];
  LocalNotifications localNotifications = LocalNotifications();

  Appointment appointment = Appointment(
      appointmentId: "",
      doctorName: "",
      title: "",
      clinicName: "",
      date: DateTime.now(),
      userId: "");

  @override
  void initState() {
    super.initState();
    listenToNotification();
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification popped up");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add New Appointment"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldWidget(
                    callback: (String val) {
                      setState(() {
                        appointment.title = val;
                      });
                    },
                    hintText: "Title",
                    label: "Title",
                    type: "String",
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    callback: (String val) {
                      setState(() {
                        appointment.doctorName = val;
                      });
                    },
                    hintText: "Name of Doctor",
                    label: "Name of Doctor",
                    type: "String",
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    callback: (String val) {
                      setState(() {
                        appointment.clinicName = val;
                      });
                    },
                    hintText: "Clinic Name",
                    label: "Clinic Name",
                    type: "String",
                  ),
                  const SizedBox(height: 10),
                  DatePickerWidget(
                    callback: (String val) {
                      setState(() {
                        appointment.date = DateTime.parse(val);
                      });
                    },
                    hintText: "Date",
                    label: "Date",
                  ),
                  Column(
                    children: textFields
                        .map((field) => field['widget'] as Widget)
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    style: 'filled',
                    label: "Add Appointment",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          appointment.userId = widget.id;
                        });

                        // Add appointment
                        String res = await context
                            .read<AppointmentProvider>()
                            .addAppointment(appointment.toJson(appointment));

                        if (context.mounted && res == "Successfully added!") {
                          final snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content:
                                const Text('Added appointment successfully!'),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);

                          await localNotifications
                              .showScheduledNotificationAppointment(
                            context,
                            id: widget.id,
                            date: appointment.date!,
                            title: "Appointment Reminder",
                            body:
                                "You have an appointment with ${appointment.doctorName}!",
                            payload: "Appointment Reminder",
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
