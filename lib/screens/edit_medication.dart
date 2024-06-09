import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medication_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/local_notifications.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/timepicker.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditMedicationScreen extends StatefulWidget {
  final MedicationIntake med;
  const EditMedicationScreen({required this.med, super.key});

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  static int indexCounter = 1;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];

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

  @override
  Widget build(BuildContext context) {
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print(widget.med.toJson(widget.med));
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Edit Medication"),
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
                  isDisabled: true,
                  initialValue: widget.med.name,
                  callback: (String val) {
                    setState(() {
                      widget.med.name = val;
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
                  initialValue: widget.med.dose,
                  isDisabled: true,
                  callback: (String val) {
                    setState(() {
                      widget.med.dose = val;
                    });
                  },
                  hintText: "Dosage",
                  label: "Dosage",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(
                    widget.med.time.length,
                    (index) => TimePickerWidget(
                      initialValue: widget.med.time[index],
                      callback: (String value) {
                        setState(() {
                          widget.med.time[index] = value;
                        });
                      },
                      hintText: "Time",
                      label: "Time",
                    ),
                  ),
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
                  height: 20,
                ),
                ButtonWidget(
                    style: 'filled',
                    label: "Edit",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          // widget.med.userId = widget.id;
                        });

                        List<String> times = textFields
                            .map((item) => item['value'] as String)
                            .toList();
                        times.insertAll(0, widget.med.time);
                        widget.med.time = times;

                        // TODO: MOVE THIS TO /chooseReadOptionScreen
                        String res = await context
                            .read<MedicationProvider>()
                            .editMedication(widget.med.medicationId!,
                                widget.med.toJson(widget.med));

                        if (context.mounted && res == "Successfully edited!") {
                          final snackBar = SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            content:
                                const Text('Medication edited successfully!'),
                            action: SnackBarAction(
                                label: 'Close', onPressed: () {}),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                          await LocalNotifications.showScheduledNotification(
                              title: "Medication Reminder",
                              body: "Time to take your ${widget.med.name}!",
                              payload: "Medication Reminder");
                          // Navigator.pushNamed(
                          //     context, '/chooseReadOptionScreen');
                        }
                      }
                    }),
                ButtonWidget(
                  style: 'outlined',
                  label: "Delete",
                  callback: () {},
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
