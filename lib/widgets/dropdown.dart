import 'package:diabuddy/utils/classes.dart';
import 'package:flutter/material.dart';

class FoodDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const FoodDropdown({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value.isEmpty ? null : value,
      isExpanded: true,
      hint: const Text("Select food"),
      items: classNames.entries
          .map((entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
