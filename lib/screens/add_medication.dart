import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/local_notifications.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/timepicker.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddMedicationScreen extends StatefulWidget {
  final String id;
  const AddMedicationScreen({required this.id, super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  static int indexCounter = 1;
  var uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];
  LocalNotifications localNotifications = LocalNotifications();
  late int uniqueId;
  late MedicationIntake medicationIntake;

  String dropdownvalue = 'None';

  @override
  void initState() {
    super.initState();
    listenToNotification();
    String v1 = uuid.v1();
    uniqueId = v1.hashCode;
    medicationIntake = MedicationIntake(
        medicationId: "",
        channelId: uniqueId,
        userId: "",
        name: "Biogesic",
        time: [],
        dose: "",
        frequency: 'None',
        isVerifiedBy: false,
        isActive: true);
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    print("=======================================Listening to notification");
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification clicked");
      print(event);
    });
  }

  void _addNewTextField() {
    setState(() {
      textFields.add({
        'widget': _buildTextField(indexCounter),
        'index': indexCounter,
        'value': ''
      });
      indexCounter++;
    });
  }

  void _deleteTextField(int index) {
    setState(() {
      int textFieldIndex =
          textFields.indexWhere((field) => field['index'] == index);
      if (textFieldIndex != -1) {
        textFields.removeAt(textFieldIndex);
      }
    });
  }

  Widget _buildTextField(int index) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: TimePickerWidget(
                  callback: (String val) {
                    setState(() {
                      int textFieldIndex = textFields
                          .indexWhere((field) => field['index'] == index);
                      if (textFieldIndex != -1) {
                        textFields[textFieldIndex]['value'] = val;
                      }
                    });
                  },
                  hintText: "Time",
                  label: "Time",
                ),
              ),
              InkWell(
                onTap: () => _deleteTextField(index),
                child: Ink(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    Icons.remove_circle_outline,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

  var items = [
    'None',
    'Everyday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Add New Medication"),
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
                      medicationIntake.name = val;
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
                  callback: (String val) {
                    setState(() {
                      medicationIntake.dose = val;
                    });
                  },
                  hintText: "Dosage",
                  label: "Dosage",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                TimePickerWidget(
                  callback: (String value) {
                    setState(() {
                      medicationIntake.time.clear();
                      medicationIntake.time.add(value);
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
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => _addNewTextField(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text2Widget(text: "Add time", style: "body2"),
                        ],
                      ),
                    ),
                  ),
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
                    value: medicationIntake.frequency,
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
                        medicationIntake.frequency = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    style: 'filled',
                    label: "Verify",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          medicationIntake.userId = widget.id;
                        });

                        List<String> times = textFields
                            .map((item) => item['value'] as String)
                            .toList();
                        times.insertAll(0, medicationIntake.time);
                        medicationIntake.time = times;

                        print("time: ${medicationIntake.time}");
                        print("frequency: ${medicationIntake.frequency}");

                        // TODO: MOVE THIS TO /chooseReadOptionScreen

                        context
                            .read<MedicationBloc>()
                            .add(AddMedication(medicationIntake));

                        print(medicationIntake.time);

                        // && res == "Successfully added!"
                        if (context.mounted) {
                          final snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content:
                                const Text('Added medication successfully!'),
                            action: SnackBarAction(
                                label: 'Close', onPressed: () {}),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          await localNotifications.showScheduledNotification(
                              context,
                              id: widget.id,
                              medicationId: uniqueId,
                              title: "Medication Reminder",
                              time: medicationIntake.time,
                              frequency: medicationIntake.frequency,
                              body:
                                  "Time to take your ${medicationIntake.name}!",
                              payload: "Medication Reminder");

                          // Navigator.pushNamed(
                          //     context, '/chooseReadOptionScreen');

                          if (!context.mounted) return;
                          Navigator.pop(context);
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
