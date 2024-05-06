import 'package:flutter/material.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';

class SemiCircleProgressBar extends StatefulWidget {
  final String title;
  const SemiCircleProgressBar({required this.title, super.key});

  @override
  State<SemiCircleProgressBar> createState() => _SemiCircleProgressBarState();
}

class _SemiCircleProgressBarState extends State<SemiCircleProgressBar> {
  @override
  Widget build(BuildContext context) {
    return SemicircularIndicator(
      radius: 100,
      color: Colors.orange,
      backgroundColor: Colors.grey[300]!,
      strokeWidth: 13,
      bottomPadding: 0,
      contain: true,
      progress: 0.75,
      child: const Text(
        '75%',
        style: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w600, color: Colors.orange),
      ),
    );
  }
}
