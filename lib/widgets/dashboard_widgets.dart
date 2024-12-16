import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  final String header;
  final int calReq;
  final double value;
  final double? caloriesValue;
  const DashboardWidget(
      {required this.header, required this.calReq, required this.value, this.caloriesValue, super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final nullText = const Color.fromARGB(74, 32, 35, 34);
  final goodText = const Color.fromARGB(255, 19, 98, 93);
  final fairText = const Color.fromRGBO(249, 166, 32, 1);
  final badText = const Color.fromRGBO(249, 32, 32, 1);

  final nullBackground = const Color.fromARGB(73, 189, 180, 181);
  final goodBackground = const Color.fromRGBO(100, 204, 197, 0.3);
  final fairBackground = const Color.fromRGBO(249, 166, 32, 0.3);
  final badBackground = const Color.fromRGBO(249, 32, 32, 0.3);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    if (widget.header == "Carbohydrates") {
      if (widget.value == 0.0) {
        backgroundColor = nullBackground;
        textColor = nullText;
      } else if (widget.value >= 0.55 * widget.caloriesValue! && widget.value <= 0.7 * widget.caloriesValue!) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else if (widget.value <= 0.55 * widget.caloriesValue!) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else if (widget.value >= 0.7 * widget.caloriesValue!) {
        backgroundColor = badBackground;
        textColor = badText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    } else if (widget.header == "Glycemic Index") {
      if (widget.value == 0.0) {
        backgroundColor = nullBackground;
        textColor = nullText;
      } else if (widget.value >= 56 && widget.value <= 69) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else if (widget.value <= 55) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    } else if (widget.header == "Diet Diversity Score") {
      if (widget.value == 0.0) {
        backgroundColor = nullBackground;
        textColor = nullText;
      } else if (widget.value <= 3) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else if (widget.value > 4.0 && widget.value <= 5) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    } else if (widget.header == "Calories") {
      if (widget.value == 0.0) {
        backgroundColor = nullBackground;
        textColor = nullText;
      } else if (widget.value >= (widget.calReq * 0.8) && widget.value < widget.calReq) {
        backgroundColor = fairBackground;
        textColor = fairText;
      } else if (widget.value <= widget.calReq) {
        backgroundColor = goodBackground;
        textColor = goodText;
      } else {
        backgroundColor = badBackground;
        textColor = badText;
      }
    } else {
      backgroundColor = badBackground;
      textColor = badText;
    }

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.header,
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic)),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Text(widget.value.toStringAsFixed(2), style: TextStyle(color: textColor, fontSize: 22)),
            Text(
                widget.header == "Calories"
                    ? " kCal"
                    : widget.header == "Carbohydrates"
                        ? " grams"
                        : "",
                style: const TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 15)),
          ],
        ),
      ]),
    );
  }
}
