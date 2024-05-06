import 'package:diabuddy/widgets/history_row.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class HistoryAllScreen extends StatefulWidget {
  const HistoryAllScreen({super.key});

  @override
  State<HistoryAllScreen> createState() => _HistoryAllScreenState();
}

class _HistoryAllScreenState extends State<HistoryAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "History", style: 'bodyLarge'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200]),
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: TextWidget(text: "Date", style: "bodyMedium")),
                    Expanded(
                        child: TextWidget(text: "HIS", style: "titleSmall")),
                    Expanded(
                        child: TextWidget(text: "GI", style: "titleSmall")),
                    Expanded(
                        child: TextWidget(text: "DDI", style: "titleSmall")),
                  ],
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Divider(color: Colors.grey[400]),
                const SizedBox(
                  height: 2.0,
                ),
                const HistoryRow(
                    date: "Dec 22", his: 10.0, gi: 10.0, ddi: 10.0),
                const SizedBox(
                  height: 10.0,
                ),
                const HistoryRow(date: "Dec 21", his: 7.5, gi: 8.0, ddi: 9.0),
                const SizedBox(
                  height: 10.0,
                ),
                const HistoryRow(
                    date: "Dec 20", his: 10.0, gi: 10.0, ddi: 10.0),
                const SizedBox(
                  height: 10.0,
                ),
                const HistoryRow(date: "Dec 19", his: 7.5, gi: 8.0, ddi: 9.0),
                const SizedBox(
                  height: 10.0,
                ),
                const HistoryRow(
                    date: "Dec 18", his: 10.0, gi: 10.0, ddi: 10.0),
                const SizedBox(
                  height: 10.0,
                ),
                const HistoryRow(date: "Dec 17", his: 7.5, gi: 8.0, ddi: 9.0),
              ]),
            )
          ],
        ),
      )),
    );
  }
}
