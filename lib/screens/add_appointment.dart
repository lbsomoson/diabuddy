import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/provider/appointments/appointments_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/datepicker.dart';
import 'package:diabuddy/widgets/local_notifications.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddAppointmentScreen extends StatefulWidget {
  final String id;
  const AddAppointmentScreen({required this.id, super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  var uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];
  LocalNotifications localNotifications = LocalNotifications();
  late int uniqueId;

  late Appointment appointment;
  TimeOfDay time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    listenToNotification();
    String v1 = uuid.v1();
    uniqueId = v1.hashCode;
    appointment = Appointment(
        appointmentId: "",
        channelId: uniqueId,
        doctorName: "",
        title: "",
        clinicName: "",
        date: DateTime.now(),
        userId: "");
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification popped up");
    });
  }

  // function to merge selected date and time into DateTime
  void _mergeDateAndTime(TimeOfDay time) {
    setState(() {
      appointment.date = DateTime(
        appointment.date!.year,
        appointment.date!.month,
        appointment.date!.day,
        time.hour,
        time.minute,
      );
    });
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    // Check if the string contains "AM" or "PM"
    bool isPm = timeString.toLowerCase().contains('pm');
    bool isAm = timeString.toLowerCase().contains('am');

    // Remove any non-time parts like AM/PM
    String cleanedTime = timeString.replaceAll(RegExp(r'[^\d:]'), '').trim();

    // Split the cleaned string into hours and minutes
    final parts = cleanedTime.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    // Convert 12-hour time to 24-hour format if necessary
    if (isPm && hour != 12) {
      hour += 12; // Convert PM to 24-hour format
    } else if (isAm && hour == 12) {
      hour = 0; // Convert 12 AM to 00
    }

    return TimeOfDay(hour: hour, minute: minute);
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
                        try {
                          // Ensure the date is in the 'yyyy-MM-dd' format before parsing
                          if (val.contains('/')) {
                            // If the date uses '/' as a separator (e.g., "12/31/2024"), convert it to 'yyyy-MM-dd'
                            List<String> parts = val.split('/');
                            val = '${parts[2]}-${parts[0]}-${parts[1]}';
                          }
                          appointment.date = DateTime.parse(val);
                        } catch (e) {
                          print("Invalid date format");
                        }
                      });
                    },
                    hintText: "Date",
                    label: "Date",
                  ),
                  const SizedBox(height: 10),
                  TimePickerWidget(
                    callback: (String value) {
                      setState(() {
                        time = stringToTimeOfDay(value);
                      });
                    },
                    hintText: "Time",
                    label: "Time",
                  ),
                  Column(
                    children: textFields
                        .map((field) => field['widget'] as Widget)
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  BlocListener<AppointmentBloc, AppointmentState>(
                    listener: (context, state) {
                      if (state is AppointmentAdded) {
                        // get the appointment ID from the success state
                        String appointmentId = state.appointmentId;
                        print(
                            "ID ++++++++++++++++++++++++++++++++++ $appointmentId");

                        // display the snack bar or trigger notifications
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

                        // trigger local notifications using appointment ID
                        // localNotifications.showScheduledNotificationAppointment(
                        //   context,
                        //   id: widget.id,
                        //   appointmentId: appointment.channelId,
                        //   date: appointment.date!,
                        //   title: "Appointment Reminder",
                        //   body:
                        //       "You have an appointment with ${appointment.doctorName}!",
                        //   payload: "Appointment Reminder",
                        // );

                        // pop the screen after processing the appointment
                        Navigator.pop(context);
                      } else if (state is AppointmentError) {
                        // handle errors if needed
                        print("Error: ${state.message}");
                      }
                    },
                    child: ButtonWidget(
                      style: 'filled',
                      label: "Add Appointment",
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            appointment.userId = widget.id;
                          });

                          _mergeDateAndTime(time);

                          // dispatch the event to add appointment
                          context
                              .read<AppointmentBloc>()
                              .add(AddAppointment(appointment));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
