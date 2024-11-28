import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:diabuddy/provider/appointments/appointments_bloc.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/screens/add_appointment.dart';
import 'package:diabuddy/screens/add_medication.dart';
import 'package:diabuddy/screens/edit_appointment.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  AppUser? appuser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // use context.read here to initialize user and fetch data
    user ??= context.read<UserAuthProvider>().user;
    appuser ??= context.watch<UserAuthProvider>().userInfo;

    if (user != null) {
      context.read<MedicationBloc>().add(LoadMedications(user!.uid));
      context.read<AppointmentBloc>().add(LoadAppointments(user!.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      // show a loading indicator or a message if `user` is not available yet
      return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (appuser == null) {
      // fetch user info if `appuser` is not loaded yet
      context.read<UserAuthProvider>().getUserInfo(user!.uid);
    }

    double computeBmi() {
      double bmi = 0;
      if (appuser?.weight != null && appuser?.height != null) {
        bmi = ((appuser?.weight)! / (appuser!.height! * appuser!.height!));
      }
      return bmi;
    }

    String classifyBmi(double bmi) {
      if (bmi < 18.5) {
        return "Underweight";
      } else if (bmi >= 18.5 && bmi <= 22.9) {
        return "Normal";
      } else if (bmi >= 23 && bmi <= 24.9) {
        return "Overweight";
      } else if (bmi >= 25) {
        return "Obese";
      } else {
        return "N/A"; // Handle invalid BMI cases
      }
    }

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
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.network(
                        user!.photoURL!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                  Row(crossAxisAlignment: CrossAxisAlignment.center, textBaseline: TextBaseline.alphabetic, children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextWidget(text: "Personal Information", style: 'labelMedium'),
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
                    child: Column(
                      children: [
                        PersonalInformation(title: "Gender", value: appuser?.gender ?? "N/A"),
                        const SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(title: "Age", value: appuser?.age?.toString() ?? "N/A"),
                        const SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                            title: "Height", value: "${appuser?.height?.toStringAsFixed(2) ?? "N/A"} m", icon: null),
                        const SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                            title: "Weight", value: "${appuser?.weight?.toStringAsFixed(2) ?? "N/A"} kg", icon: null),
                        const SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                          title: "BMI",
                          value: "${computeBmi().toStringAsFixed(2)} kg/m\u00B2, ${classifyBmi(computeBmi())}",
                          icon: Icons.info_outline,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(
                          title: "Activity",
                          value: appuser?.activityLevel ?? "N/A",
                          icon: Icons.info_outline,
                        ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Row(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: TextWidget(text: "Medicine", style: 'labelMedium'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return AddMedicationScreen(id: user!.uid);
                                })),
                                child: Ink(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                  ),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 22,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => {Navigator.pushNamed(context, '/medicationHistory')},
                          child: Text("History", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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
                        child: TextWidget(text: "Medical Appointments", style: 'labelMedium'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                              size: 22,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _displayAppointments(context, user!.uid),
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
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
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
                          Navigator.pushNamedAndRemoveUntil(context, '/loginScreen', (Route<dynamic> route) => false);
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
  return BlocBuilder<MedicationBloc, MedicationState>(
    builder: (context, state) {
      if (state is MedicationLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is MedicationLoaded) {
        if (state.medications.isEmpty) {
          return const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Center(child: Text2Widget(text: "No medicines yet", style: 'body2'))]),
          );
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.medications.length,
          itemBuilder: (context, index) {
            MedicationIntake medication = state.medications[index];
            medication.medicationId = state.medications[index].medicationId;

            if (medication.isActive == true) {
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
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      } else {
        return const Center(
          child: Text("Error encountered!"),
        );
      }
    },
  );
}

Widget _displayAppointments(BuildContext context, String id) {
  String dateFormatted(DateTime date) {
    return "${date.month}/${date.day}/${date.year}";
  }

  return BlocBuilder<AppointmentBloc, AppointmentState>(builder: (context, state) {
    if (state is AppointmentLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is AppointmentLoaded) {
      if (state.appointments.isEmpty) {
        return const Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Center(child: Text2Widget(text: "No medical appointments yet", style: 'body2'))]),
        );
      }
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.appointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = state.appointments[index];
          appointment.appointmentId = state.appointments[index].appointmentId;

          return CardWidget(
            leading: FontAwesomeIcons.pills,
            callback: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditAppointmentScreen(appointment: appointment);
              }));
            },
            trailing: Icons.edit,
            title: appointment.title,
            subtitle: dateFormatted(appointment.date!),
          );
        },
      );
    } else if (state is AppointmentAdded) {
      final allAppointments = state.appointments;

      // display the appointments with the new appointment added
      return ListView.builder(
        shrinkWrap: true,
        itemCount: allAppointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = allAppointments[index];
          appointment.appointmentId = allAppointments[index].appointmentId;

          return CardWidget(
            leading: FontAwesomeIcons.pills,
            callback: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditAppointmentScreen(appointment: appointment);
              }));
            },
            trailing: Icons.edit,
            title: appointment.title,
            subtitle: dateFormatted(appointment.date!),
          );
        },
      );
    } else {
      return const Center(
        child: Text("Error encountered!"),
      );
    }
  });
}

void _editPersonalInformation(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
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
