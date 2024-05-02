import 'package:diabuddy/widgets/button.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:diabuddy/widgets/textfield.dart';
import 'package:flutter/material.dart';

class ChooseReadOptionScreen extends StatefulWidget {
  const ChooseReadOptionScreen({super.key});

  @override
  State<ChooseReadOptionScreen> createState() => _ChooseReadOptionScreenState();
}

class _ChooseReadOptionScreenState extends State<ChooseReadOptionScreen> {
  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: EdgeInsets.all(20),
              constraints: BoxConstraints(maxHeight: 346),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                        callback: () {},
                        hintText: "PTR Number",
                        label: 'PTR Number',
                        type: "String"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        callback: () {},
                        hintText: "License Number",
                        label: 'License Number',
                        type: "String"),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(label: "Save", callback: () {})
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const TextWidget(text: "Prescription Reader", style: 'bodyLarge'),
          const SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Set the border color to primary color
                width: 2.0, // Set the border width
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                splashColor:
                    Theme.of(context).colorScheme.secondary, // splash color
                onTap: () {}, // button pressed
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.photo_size_select_actual_rounded,
                      color: Color.fromRGBO(100, 204, 197, 1),
                      size: 100,
                    ), // icon
                    Text("I-upload mula sa gallery",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(100, 204, 197, 1),
                        )), // text
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Set the border color to primary color
                width: 2.0, // Set the border width
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            width: double.infinity,
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15.0),
                splashColor:
                    Theme.of(context).colorScheme.secondary, // splash color
                onTap: () {
                  _showDialog(context);
                }, // button pressed
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Icon(
                      Icons.edit_note_sharp,
                      color: Color.fromRGBO(100, 204, 197, 1),
                      size: 100,
                    ), // icon
                    Text("Ilagay ang PTR at license number",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(100, 204, 197, 1),
                        )), // text
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
