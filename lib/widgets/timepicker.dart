import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(String) callback;
  final String hintText;
  final String? label;
  final bool? isRequired;

  const TimePickerWidget({
    required this.callback,
    this.label,
    this.isRequired,
    required this.hintText,
    super.key,
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "";
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _controller.text = selectedTime.format(context);
      });
      widget.callback(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
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
        GestureDetector(
          onTap: () {
            _selectTime(context);
          },
          child: AbsorbPointer(
            child: TextFormField(
                readOnly: true,
                controller: _controller,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                  fontSize: 16,
                ),
                onSaved: (value) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter ${widget.label?.toLowerCase()}";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0),
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
                )),
          ),
        ),
      ],
    );
  }
}
