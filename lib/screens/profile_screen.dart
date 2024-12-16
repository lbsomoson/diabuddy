import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/models/appointment_model.dart';
import 'package:diabuddy/models/user_model.dart';
import 'package:diabuddy/provider/appointment_provider.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/medication_provider.dart';
import 'package:diabuddy/screens/add_appointment.dart';
import 'package:diabuddy/screens/add_medication.dart';
import 'package:diabuddy/screens/edit_appointment.dart';
import 'package:diabuddy/screens/edit_medication.dart';
import 'package:diabuddy/screens/edit_profile.dart';
import 'package:diabuddy/services/database_service.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/personal_info.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? dropdownValue, age, height, weight;
  User? user;
  AppUser? appuser;
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    user = context.read<UserAuthProvider>().user;
    appuser ??= context.watch<UserAuthProvider>().userInfo;
    Future<List<MedicationIntake>> medications = context.watch<MedicationProvider>().getMedications(user!.uid);
    Future<List<Appointment>> appointments = context.watch<AppointmentProvider>().getAppointments(user!.uid);

    double computeIdealBodyWeight() {
      double idw = 0.0;
      if (appuser?.height != null) {
        idw = ((appuser!.height! * 100) - 100) - (0.1 * ((appuser!.height! * 100) - 100));
      }
      return idw;
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
        return "N/A";
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return EditProfileScreen(appuser: appuser);
                          }));
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
                            title: "IBW", value: "${computeIdealBodyWeight().toStringAsFixed(2)} kg", icon: null),
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
                  _displayMedicines(context, user!.uid, medications),
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
                  _displayAppointments(context, user!.uid, appointments),
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

  Widget _displayMedicines(BuildContext context, String id, Future<List<MedicationIntake>> medications) {
    return FutureBuilder(
        future: medications,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
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
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                MedicationIntake medication = snapshot.data[index] as MedicationIntake;

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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: Text2Widget(text: "No medicines yet", style: 'body2'))]),
            );
          }
        });
  }

  Widget _displayAppointments(BuildContext context, String id, Future<List<Appointment>> appointments) {
    String dateFormatted(DateTime date) {
      return "${date.month}/${date.day}/${date.year}";
    }

    return FutureBuilder(
        future: appointments,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: Text2Widget(text: "No appointments yet", style: 'body2'))]),
              );
            }
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Appointment appointment = snapshot.data[index] as Appointment;

                  return CardWidget(
                    leading: FontAwesomeIcons.pills,
                    callback: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return EditAppointmentScreen(appointment: appointment);
                      }));
                    },
                    trailing: Icons.edit,
                    title: appointment.title,
                    subtitle: dateFormatted(appointment.date),
                  );
                });
          } else {
            return const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Center(child: Text2Widget(text: "No appointments yet", style: 'body2'))]),
            );
          }
        });
  }
}
