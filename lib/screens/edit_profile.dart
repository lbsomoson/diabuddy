import 'package:diabuddy/models/user_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/widgets/appbar_title.dart';
import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final AppUser? appuser;
  const EditProfileScreen({this.appuser, super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue, age, height, weight;
  List<String> levels = ["Sedentary", "Light", "Moderate", "Very Active or Vigorous"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: "Edit Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldWidget(
                  callback: (String value) {
                    age = value;
                  },
                  hintText: "Age",
                  label: "Age",
                  type: "String",
                  initialValue: widget.appuser!.age?.toString(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  callback: (String value) {
                    height = value;
                  },
                  hintText: "Height (in meters)",
                  label: "Height",
                  type: "String",
                  initialValue: widget.appuser!.height?.toString(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  callback: (String value) {
                    weight = value;
                  },
                  hintText: "Weight (in kg)",
                  label: "Weight",
                  type: "String",
                  initialValue: widget.appuser!.weight?.toStringAsFixed(2),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  value: dropdownValue ?? widget.appuser!.activityLevel,
                  isExpanded: true,
                  hint: const Text("Select activity level"),
                  items: levels.map((entry) {
                    return DropdownMenuItem(
                      value: entry,
                      child: Text(entry),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    style: 'filled',
                    label: "Save",
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        dropdownValue ??= widget.appuser!.activityLevel;
                        age ??= widget.appuser!.age.toString();
                        weight ??= widget.appuser!.weight.toString();
                        height ??= widget.appuser!.height.toString();

                        widget.appuser!.activityLevel = dropdownValue;
                        widget.appuser!.age = int.tryParse(age!);
                        widget.appuser!.height = double.tryParse(height!);
                        widget.appuser!.weight = double.tryParse(weight!);

                        context.read<UserAuthProvider>().editUser(
                              widget.appuser!.userId!,
                              widget.appuser!.age!,
                              widget.appuser!.height!,
                              widget.appuser!.weight!,
                              widget.appuser!.activityLevel!,
                            );
                        if (context.mounted) Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
