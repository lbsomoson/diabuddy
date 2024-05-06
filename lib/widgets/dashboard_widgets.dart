import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  final String header;
  final double value;
  const DashboardWidget({required this.header, required this.value, super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final goodText = const Color.fromARGB(255, 19, 98, 93);
  final fairText = const Color.fromRGBO(249, 166, 32, 1);
  final badText = const Color.fromRGBO(249, 32, 32, 1);

  final goodBackground = const Color.fromRGBO(100, 204, 197, 0.3);
  final fairBackground = const Color.fromRGBO(249, 166, 32, 0.3);
  final badBackground = const Color.fromRGBO(249, 32, 32, 0.3);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (widget.header == "Carbohydrates") {
      if (widget.value <= 225) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else if (widget.value <= 325 && widget.value > 225) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    } else {
      if (widget.value >= 7.5) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else if (widget.value >= 5.0 && widget.value <= 7.4) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: backgroundColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.header,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic)),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Text(widget.value.toString(),
                style: TextStyle(color: textColor, fontSize: 22)),
            Text(
                widget.header == "Calories"
                    ? " kCal"
                    : widget.header == "Carbohydrates"
                        ? " grams"
                        : "",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 15)),
          ],
        ),
      ]),
    );
  }
}
