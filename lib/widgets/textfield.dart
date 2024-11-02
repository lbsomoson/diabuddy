import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final Function callback;
  final String? initialValue;
  final String hintText, type;
  final String? label;
  final bool? isDisabled;
  const TextFieldWidget(
      {required this.callback,
      this.label,
      this.initialValue,
      this.isDisabled,
      required this.hintText,
      required this.type,
      super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final RegExp regExp = RegExp(r'[\d]+'); // regex for numbers

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextWidget(text: widget.label!, style: 'bodyMedium'),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
        TextFormField(
          style: Theme.of(context).textTheme.labelSmall,
          onSaved: (value) {
            print("Text value: $value");
          },
          validator: (value) {
            // asks for a value if the textfield is empty
            if (value == null || value.isEmpty) {
              return "Please enter your ${widget.hintText.toLowerCase()}";
            }
            // if the type is a number, it checks if the value is a number
            if (widget.type == "Number" && int.tryParse(value) == null) {
              return "Please enter a number";
            }
            return null;
          },
          readOnly: widget.isDisabled ?? false,
          initialValue: widget.initialValue,
          onChanged: (value) => {
            if (value.isNotEmpty) // value != null &&
              {
                if (widget.type == "Number")
                  {widget.callback(int.parse(value))}
                else
                  {widget.callback(value)}
              }
          },
          obscureText: widget.type == "Password",
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
