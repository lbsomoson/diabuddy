import 'package:flutter/material.dart';

class IconButtonWidget extends StatefulWidget {
  final String icon, label;
  final Function callback;
  const IconButtonWidget(
      {required this.callback,
      required this.icon,
      required this.label,
      super.key});

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: () {
          widget.callback();
        },
        label: Text(widget.label),
        icon: Image.asset(
          widget.icon,
          width: 20,
          height: 20,
        ));
  }
}
