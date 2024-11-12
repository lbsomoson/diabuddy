import 'package:diabuddy/models/medication_intake_model.dart';
import 'package:diabuddy/provider/medications/medications_bloc.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/utils/local_notifications.dart';
import 'package:diabuddy/widgets/text.dart';
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
  final _formKey = GlobalKey<FormState>();
  List<TimeOfDay?> timeValues = [];
  LocalNotifications localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    listenToNotification();
  }

  // to listen to any notification clicked or not
  listenToNotification() {
    LocalNotifications.onClickNotification.stream.listen((event) {
      print("Notification popped up");
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
                TextFieldWidget(
                  initialValue: widget.med.verifiedBy!['ptrNo'],
                  isDisabled: true,
                  callback: (String val) {
                    setState(() {
                      widget.med.verifiedBy!['ptrNo'] = val;
                    });
                  },
                  hintText: "PTR Number",
                  label: "PTR Number",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  initialValue: widget.med.verifiedBy!['licenseNo'],
                  isDisabled: true,
                  callback: (String val) {
                    setState(() {
                      widget.med.verifiedBy!['licenseNo'] = val;
                    });
                  },
                  hintText: "License Number",
                  label: "License Number",
                  type: "String",
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.med.time.isEmpty
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 5.0);
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.med.time.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TimePickerWidget(
                                  initialValue: widget.med.time[index],
                                  callback: (String value) {
                                    setState(() {
                                      widget.med.time[index] = value;
                                    });
                                  },
                                  hintText: "Time",
                                  label: index == 0 ? "Time" : null,
                                );
                              })
                        ],
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
                            size: 22,
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
                    // value: dropdownvalue,
                    value: widget.med.frequency,
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
                        widget.med.frequency = newValue!;
                      });
                    },
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
                        List<String> stringList = timeValues
                            .map<String>((time) => formatTimeOfDay(time!))
                            .toList();

                        widget.med.time = widget.med.time + stringList;

                        context.read<MedicationBloc>().add(UpdateMedication(
                            widget.med, widget.med.medicationId!));

                        // TODO: MOVE THIS TO /chooseReadOptionScreen

                        if (context.mounted) {
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
                          await localNotifications.updateScheduledNotification(
                              context,
                              medicationId: widget.med.channelId,
                              time: widget.med.time,
                              frequency: widget.med.frequency,
                              title: "Medication Reminder",
                              body: "Time to take your ${widget.med.name}!",
                              payload: "Medication Reminder");
                        }
                      }
                    }),
                const SizedBox(height: 12),
                ButtonWidget(
                  style: 'outlined',
                  label: "Delete",
                  callback: () async {
                    context
                        .read<MedicationBloc>()
                        .add(DeleteMedication(widget.med.medicationId!));

                    await localNotifications.cancelScheduledNotifications(
                        medicationId: widget.med.channelId,
                        time: widget.med.time);

                    if (context.mounted) {
                      final snackBar = SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: const Text('Medication deleted successfully!'),
                        action:
                            SnackBarAction(label: 'Close', onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
