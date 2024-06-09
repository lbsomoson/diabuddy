import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medication_provider.dart';
import 'package:diabuddy/provider/appointment_provider.dart';
import 'package:diabuddy/screens/add_appointment.dart';
import 'package:diabuddy/screens/add_medication.dart';
import 'package:diabuddy/screens/edit_medication.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/personal_info.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  List<Map<String, dynamic>> medicines = [
    {
      "name": "Biogesic",
      "frequency": "2",
      "time": ["9:00 AM", "9:00 PM"]
    },
    {
      "name": "Biogesic",
      "frequency": "2",
      "time": ["9:00 AM", "9:00 PM"]
    },
    {
      "name": "Biogesic",
      "frequency": "2",
      "time": ["9:00 AM", "9:00 PM"]
    },
    {
      "name": "Biogesic",
      "frequency": "2",
      "time": ["9:00 AM", "9:00 PM"]
    }
  ];

  List<Map<String, dynamic>> appointments = [
    {
      "title": "Appointment with Doctor 1",
      "date": "June 2, 2024",
      "time": "9:00 AM",
    },
    {
      "title": "Appointment with Doctor 2",
      "date": "June 2, 2024",
      "time": "10:00 AM",
    },
  ];

  void _editPersonalInformation(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 380),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Age",
                      label: "Age",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Height",
                      label: "Height",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Weight",
                      label: "Weight",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        style: 'filled',
                        label: "Save",
                        callback: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _editAppointmentInformation(
      context, String title, String time, String date) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 380),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Title",
                      label: "Title",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Date",
                      label: "Date",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Time",
                      label: "Time",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        style: 'filled',
                        label: "Save",
                        callback: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _editMedicineInformation(
      context, String title, String subtitle, String frequency) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 380),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Medicine Name",
                      label: "Medicine Name",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Time",
                      label: "Time",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Frequency",
                      label: "Frequency",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        style: 'filled',
                        label: "Verify",
                        callback: () {
                          Navigator.pop(context);
                          // Navigator.pushNamed(
                          //     context, '/chooseReadOptionScreen');
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _addAppointmentInformation(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 380),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Title",
                      label: "Title",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Date",
                      label: "Date",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      callback: () {},
                      hintText: "Time",
                      label: "Time",
                      type: "String",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        style: 'filled',
                        label: "Save",
                        callback: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Profile"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(300.0),
                        child: Image(
                            width: 80,
                            height: 80,
                            image: NetworkImage(user!.photoURL!))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(text: user!.displayName ?? '', style: 'bodyLarge'),
                  TextWidget(text: user!.email ?? '', style: 'bodySmall'),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey[400]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                              text: "Personal Information",
                              style: 'labelMedium'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              _editPersonalInformation(context);
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Column(
                      children: [
                        PersonalInformation(title: "Gender", value: "Female"),
                        SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(title: "Age", value: "45"),
                        SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                            title: "Height",
                            value: "5\"11",
                            icon: Icons.verified),
                        SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                            title: "Weight",
                            value: "50 kg",
                            icon: Icons.verified),
                        SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                            title: "BMI", value: "20.5", icon: Icons.verified),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey[400]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                              text: "Medicine", style: 'labelMedium'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddMedicationScreen(id: user!.uid);
                            })),
                            child: Ink(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  _displayMedicines(context, user!.uid),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey[400]),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                              text: "Medical Appointments",
                              style: 'labelMedium'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () => {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddAppointmentScreen(id: user!.uid);
                              }))
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        )
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  _displayAppointments(context, user!.uid),
                  // Column(
                  //   children: appointments.map((app) {
                  //     return CardWidget(
                  //         leading: Icons.medical_services_rounded,
                  //         trailing: Icons.edit,
                  //         callback: () => _editAppointmentInformation(
                  //             context, app['title'], app['time'], app['date']),
                  //         title: app['title'],
                  //         subtitle: "${app['date']} at ${app['time']}");
                  //   }).toList(),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Divider(color: Colors.grey[400]),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              }
                              return Theme.of(context).colorScheme.primary;
                            },
                          ),
                        ),
                        onPressed: () {
                          context.read<UserAuthProvider>().signOut();
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/loginScreen', (Route<dynamic> route) => false);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}

Widget _displayMedicines(BuildContext context, String id) {
  return StreamBuilder(
      stream: context.watch<MedicationProvider>().getMedications(id),
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
            child: Text("No Medicines Found"),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child:
                          Text2Widget(text: "No medicines yet", style: 'body2'))
                ]),
          ));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              MedicationIntake medication = MedicationIntake.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              medication.medicationId = snapshot.data?.docs[index].id;
              return CardWidget(
                leading: FontAwesomeIcons.pills,
                callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditMedicationScreen(med: medication);
                  }));
                },
                trailing: Icons.edit,
                title: medication.name,
                subtitle: medication.time.join(", "),
              );
            });
      });
}

Widget _displayAppointments(BuildContext context, String id) {
  return StreamBuilder(
      stream: context.watch<AppointmentProvider>().getAppointments(id),
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
            child: Text("No Appointments Found"),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text2Widget(
                          text: "No appointments yet", style: 'body2'))
                ]),
          ));
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              Appointment appointment = Appointment.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              appointment.appointmentId = snapshot.data?.docs[index].id;
              return CardWidget(
                leading: Icons.medical_services_rounded,
                callback: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return EditMedicationScreen(med: appointment);
                  // }));
                },
                trailing: Icons.edit,
                title:
                    "${appointment.title} with Doctor ${appointment.doctorName}",
                subtitle: DateFormat('MMMM d, yyyy').format(appointment.date!),
              );
            });
      });
}
