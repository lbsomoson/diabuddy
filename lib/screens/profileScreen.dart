import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/iconbutton.dart';
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
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: TextWidget(
                                    text: "Age", style: 'labelLarge')),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    TextWidget(text: "45", style: 'bodySmall'),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 2,
                                child: TextWidget(
                                    text: "Gender", style: 'labelLarge')),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    TextWidget(
                                        text: "Female", style: 'bodySmall'),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 2,
                                child: TextWidget(
                                    text: "Height", style: 'labelLarge')),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const TextWidget(
                                        text: "5\"11", style: 'bodySmall'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.verified,
                                      size: 20,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 2,
                                child: TextWidget(
                                    text: "Weight", style: 'labelLarge')),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const TextWidget(
                                        text: "50 kg", style: 'bodySmall'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      size: 20,
                                      Icons.verified,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                                flex: 2,
                                child: TextWidget(
                                    text: "BMI", style: 'labelLarge')),
                            Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const TextWidget(
                                        text: "20.5", style: 'bodySmall'),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      size: 20,
                                      Icons.verified,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  ],
                                )),
                          ],
                        ),
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
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const TextWidget(text: "Medicine", style: 'labelMedium'),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      size: 20,
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: medicines.map((med) {
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Set border radius as needed
                              side: BorderSide(
                                  color:
                                      Colors.grey[300]!), // Set outline color
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.medical_services_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              trailing: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                                size: 20,
                              ),
                              title: TextWidget(
                                  text: med['name'], style: 'bodyMedium'),
                              subtitle: const TextWidget(
                                  text: "asdfadsf", style: 'bodySmall'),
                            ),
                          ),
                        );
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
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const TextWidget(
                        text: "Medical Appointments", style: 'labelMedium'),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      size: 20,
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: appointments.map((app) {
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set border radius as needed
                            side: BorderSide(
                                color: Colors.grey[300]!), // Set outline color
                          ),
                          child: ListTile(
                            leading: Icon(
                              Icons.medical_services_rounded,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            trailing: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            title: TextWidget(
                                text: app['title'], style: 'bodyMedium'),
                            subtitle: TextWidget(
                                text: "${app['date']} at ${app['time']}",
                                style: 'bodySmall'),
                          ),
                        ),
                      );
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
                  // IconButton.filled(onPressed: (){}, icon: icon)
                  // IconButtonWidget(
                  //     callback: () {},
                  //     icon: Icon(Icons.logout),
                  //     label: "Logout")
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     TextWidget(text: "Name of Medicine", style: 'titleSmall'),
                  //     TextWidget(text: "Time", style: 'titleSmall'),
                  //   ],
                  // ),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     TextWidget(text: "Name of Medicine", style: 'titleSmall'),
                  //     TextWidget(text: "Time", style: 'titleSmall'),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     const TextWidget(
                  //         text: "Add Medicine", style: 'titleSmall'),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Icon(
                  //       Icons.add_circle_outline,
                  //       color: Theme.of(context).colorScheme.primary,
                  //     )
                  //   ],
                  // )
                ]),
              ),
            ),
          ),
        ));
  }
}
