import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/provider/appointments/appointments_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/datepicker.dart';
import 'package:diabuddy/widgets/local_notifications.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAppointmentScreen extends StatefulWidget {
  final Appointment appointment;
  const EditAppointmentScreen({required this.appointment, super.key});

  @override
  State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];
  LocalNotifications localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    listenToNotification();
    print("--------------------------------------------");
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    print("=======================================Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification popped up");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Edit Appointment"),
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
                  initialValue: widget.appointment.title,
                  callback: (String val) {
                    setState(() {
                      widget.appointment.title = val;
                    });
                  },
                  hintText: "Title",
                  label: "Title",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue: widget.appointment.doctorName,
                  callback: (String val) {
                    setState(() {
                      widget.appointment.doctorName = val;
                    });
                  },
                  hintText: "Name of Doctor",
                  label: "Name of Doctor",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue: widget.appointment.clinicName,
                  callback: (String val) {
                    setState(() {
                      widget.appointment.clinicName = val;
                    });
                  },
                  hintText: "Clinic name",
                  label: "Clinic name",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                DatePickerWidget(
                    initialValue: widget.appointment.date,
                    callback: (String val) {
                      setState(() {
                        widget.appointment.date = DateTime.tryParse(val);
                      });
                    },
                    hintText: "Date",
                    label: "Date"),
                Column(
                  children: textFields
                      .map((field) => field['widget'] as Widget)
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    style: 'filled',
                    label: "Edit Appointment",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        // TODO: MOVE THIS TO /chooseReadOptionScreen

                        context.read<AppointmentBloc>().add(UpdateAppointment(
                            widget.appointment,
                            widget.appointment.appointmentId!));

                        if (context.mounted) {
                          final snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content:
                                const Text('Appointment edited successfully!'),
                            action: SnackBarAction(
                                label: 'Close', onPressed: () {}),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          await localNotifications
                              .showScheduledNotificationAppointment(context,
                                  id: widget.appointment.userId,
                                  appointmentId: widget.appointment.channelId,
                                  title: "Appointment Reminder",
                                  date: widget.appointment.date!,
                                  body:
                                      "You have an appointment with ${widget.appointment.doctorName}!",
                                  payload: "Appointment Reminder");
                        }
                      }
                    }),
                const SizedBox(height: 12),
                ButtonWidget(
                  style: 'outlined',
                  label: "Delete",
                  callback: () async {
                    context.read<AppointmentBloc>().add(
                        DeleteAppointment(widget.appointment.appointmentId!));

                    if (context.mounted) {
                      final snackBar = SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content:
                            const Text('Apppointment deleted successfully!'),
                        action:
                            SnackBarAction(label: 'Close', onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
