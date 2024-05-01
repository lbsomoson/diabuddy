import 'package:flutter/material.dart';

class TextLink extends StatefulWidget {
  final String label;
  final Function callback;
  const TextLink(
      {required this.label,
      // required this.style,
      required this.callback,
      super.key});

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.callback();
          setState(() {
            _isClicked = true;
          });
          Future.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              _isClicked = false;
            });
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.0),
            boxShadow: [
              if (_isClicked)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 1,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              widget.label,
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ));
  }
}
