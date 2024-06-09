import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Function callback;
  final String label, style;
  final double? size;
  final bool? block;
  const ButtonWidget(
      {required this.callback,
      this.block,
      this.size,
      required this.label,
      required this.style,
      super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.block != null ? null : double.infinity,
      child: widget.style == "outlined"
          ? Container(
              height: widget.size ?? 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
              child: OutlinedButton(
                onPressed: () {
                  widget.callback();
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  side: BorderSide.none,
                ),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          : Container(
              height: widget.size ?? 45,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  widget.callback();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  side: BorderSide.none,
                ),
                child: Text(
                  widget.label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ),
    );
  }
}
