import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(String) callback;
  final String hintText;
  final String? label, initialValue;
  final bool? isRequired;

  const TimePickerWidget({
    required this.callback,
    this.label,
    this.initialValue,
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
    selectedTime = widget.initialValue != null
        ? _parseTime(widget.initialValue!)
        : TimeOfDay.now();

    // Defer setting _controller.text until after initState completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.text = selectedTime.format(context);
      widget.callback(_controller
          .text); // Ensure the callback is called with the initial value
    });
  }

  TimeOfDay _parseTime(String timeString) {
    final List<String> parts = timeString.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid time format: $timeString');
    }
    final int hour = int.tryParse(parts[0]) ?? 0;
    final List<String> minuteAndAmPm = parts[1].split(' ');
    final int minute = int.tryParse(minuteAndAmPm[0]) ?? 0;
    if (hour < 0 || hour > 12 || minute < 0 || minute > 59) {
      throw FormatException('Invalid time values: $timeString');
    }
    final bool isPM =
        minuteAndAmPm.length > 1 && minuteAndAmPm[1].toUpperCase() == 'PM';
    final int adjustedHour =
        hour == 12 ? (isPM ? 12 : 0) : (isPM ? hour + 12 : hour);
    return TimeOfDay(hour: adjustedHour, minute: minute);
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
