import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medication_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:diabuddy/widgets/timepicker.dart';
import 'package:diabuddy/widgets/text2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMedicationScreen extends StatefulWidget {
  final String id;
  const AddMedicationScreen({required this.id, super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  static int indexCounter = 1;
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> textFields = [];

  MedicationIntake medicationIntake = MedicationIntake(
      medicationId: "",
      userId: "",
      name: "Biogesic",
      time: [],
      dose: "",
      isVerifiedBy: false,
      isActive: true);

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
                  height: 20,
                ),
                ButtonWidget(
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

                        // TODO: MOVE THIS TO /chooseReadOptionScreen
                        String res = await context
                            .read<MedicationProvider>()
                            .addMedication(
                                medicationIntake.toJson(medicationIntake));

                        final snackBar = SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 245, 88, 77),
                          content: const Text('Added medication successfully!'),
                          action:
                              SnackBarAction(label: 'Close', onPressed: () {}),
                        );

                        if (context.mounted && res == "Successfully added!") {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // Navigator.pushNamed(
                          //     context, '/chooseReadOptionScreen');
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
