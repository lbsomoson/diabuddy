import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  const AppBarTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          fontSize: 22),
    );
  }
}
