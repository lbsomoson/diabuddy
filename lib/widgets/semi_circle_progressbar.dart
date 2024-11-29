import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CircleProgressIndicator extends StatefulWidget {
  final String title;
  final double value;
  const CircleProgressIndicator({required this.title, required this.value, super.key});

  @override
  State<CircleProgressIndicator> createState() => _CircleProgressIndicatorState();
}

class _CircleProgressIndicatorState extends State<CircleProgressIndicator> {
  late ValueNotifier<double> valueNotifier;

  int keyForRepaint = 0;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(widget.value);
    keyForRepaint++;
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        key: ValueKey(keyForRepaint),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleCircularProgressBar(
                  onGetText: (double value) {
                    return Text(
                      '${value.toInt()}%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    );
                  },
                  progressColors: const [
                    Color.fromRGBO(241, 207, 85, 1),
                    Color.fromRGBO(247, 139, 8, 1),
                    Color.fromRGBO(250, 85, 39, 1)
                  ],
                  valueNotifier: valueNotifier,
                  size: 200,
                  progressStrokeWidth: 30,
                  backStrokeWidth: 20,
                  backColor: const Color.fromARGB(126, 253, 229, 143),
                  animationDuration: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
