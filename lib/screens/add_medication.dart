import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/utils/text_to_speech.dart';
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
  var uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();
  List<TimeOfDay?> timeValues = [];
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
      timeValues.add(null);
    });
  }

  Future<void> _updateTimeValue(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: timeValues[index] ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeValues[index] = picked;
      });
    }
  }

  void _removeTimePicker(int index) {
    setState(() {
      timeValues.removeAt(index);
    });
  }

  String formatTimeOfDay(TimeOfDay time) {
    return time.format(context);
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
                timeValues.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: timeValues.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.grey[100],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                      timeValues[index]?.format(context) ??
                                          TimeOfDay.now().format(context),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () =>
                                              _removeTimePicker(index),
                                        ),
                                      ],
                                    ),
                                    onTap: () =>
                                        _updateTimeValue(context, index),
                                  ),
                                );
                              })
                        ],
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

                        List<String> stringList = timeValues
                            .map<String>((time) => formatTimeOfDay(time!))
                            .toList();

                        // List<String> times = textFields
                        //     .map((item) => item['value'] as String)
                        //     .toList();
                        // stringList.insertAll(0, medicationIntake.time);
                        // medicationIntake.time = stringList;
                        medicationIntake.time =
                            medicationIntake.time + stringList;

                        print("time: ${medicationIntake.time}");
                        print("frequency: ${medicationIntake.frequency}");

                        // TODO: MOVE THIS TO /chooseReadOptionScreen

                        context
                            .read<MedicationBloc>()
                            .add(AddMedication(medicationIntake));

                        print(medicationIntake.time);

                        TextToSpeechService().dispose();
                        TextToSpeechService().speak(
                            "Oras na para inumin ang ${medicationIntake.name}!");
                        TextToSpeechService().dispose();

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
