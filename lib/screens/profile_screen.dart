import 'package:diabuddy/widgets/card.dart';
import 'package:diabuddy/widgets/personal_info.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      "title": "Appointment to Doctor 1",
      "date": "June 2, 2024",
      "time": "9:00 AM",
    },
    {
      "title": "Appointment to Doctor 2",
      "date": "June 2, 2024",
      "time": "10:00 AM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextWidget(text: "Profile", style: 'bodyLarge'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                // handle the press
              },
            ),
          ],
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
                      child: const Image(
                          width: 80,
                          height: 80,
                          image:
                              AssetImage('./assets/images/profile_empty.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(text: "Juan Dela Cruz", style: 'bodyLarge'),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey[500]),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                            text: "Personal Information", style: 'labelMedium')
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Column(
                      children: [
                        PersonalInformation(title: "Age", value: "45"),
                        SizedBox(
                          height: 8,
                        ),
                        PersonalInformation(title: "Gender", value: "Female"),
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
                  Divider(color: Colors.grey[500]),
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
                            onTap: () {},
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
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: medicines.map((med) {
                        return CardWidget(
                            // leading: Icons.medical_services_rounded,
                            trailing: Icons.edit,
                            title: med['name'],
                            subtitle: "asdfad");
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(color: Colors.grey[500]),
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
                            onTap: () {},
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
                  Column(
                    children: appointments.map((app) {
                      return CardWidget(
                          leading: Icons.medical_services_rounded,
                          trailing: Icons.edit,
                          title: app['title'],
                          subtitle: "${app['date']} at ${app['time']}");
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton.icon(
                      style: const ButtonStyle(
                          // foregroundColor: const Color.fromRGBO(100, 204, 197, 1),
                          ),
                      onPressed: () {},
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout")),
                ]),
              ),
            ),
          ),
        ));
  }
}
