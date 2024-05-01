import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final Function callback;
  const ButtonWidget({required this.label, required this.callback, super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: () {
          widget.callback();
        },
      ),
    );
  }
}
