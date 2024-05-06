import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class HistoryRow extends StatefulWidget {
  final String date;
  final double his, gi, ddi;
  const HistoryRow(
      {required this.date,
      required this.his,
      required this.gi,
      required this.ddi,
      super.key});

  @override
  State<HistoryRow> createState() => _HistoryRowState();
}

class _HistoryRowState extends State<HistoryRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2, child: TextWidget(text: widget.date, style: "bodyMedium")),
        Expanded(
            child:
                TextWidget(text: widget.his.toString(), style: "titleSmall")),
        Expanded(
            child: TextWidget(text: widget.gi.toString(), style: "titleSmall")),
        Expanded(
            child:
                TextWidget(text: widget.ddi.toString(), style: "titleSmall")),
      ],
    );
  }
}
