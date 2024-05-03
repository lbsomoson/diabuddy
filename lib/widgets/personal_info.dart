import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  final String title, value;
  final IconData? icon;
  const PersonalInformation(
      {required this.title, required this.value, this.icon, super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: TextWidget(text: widget.title, style: 'labelLarge')),
        Expanded(
            flex: 5,
            child: Row(
              children: [
                TextWidget(text: widget.value, style: 'bodySmall'),
                const SizedBox(
                  width: 10,
                ),
                widget.icon != null
                    ? Icon(
                        widget.icon!,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Container()
              ],
            )),
      ],
    );
  }
}
