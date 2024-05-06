import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const TextWidget(text: "History", style: 'bodyLarge')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          // health index score
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            padding:
                const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                    text: "Health Index Score", style: 'labelLarge'),
                Divider(color: Colors.grey[400]),
                const SizedBox(
                  height: 10,
                ),
                AspectRatio(
                  aspectRatio: 2.0,
                  child: LineChart(
                    LineChartData(
                        borderData: FlBorderData(
                            border: const Border(
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide.none,
                                top: BorderSide.none)),
                        // gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                          rightTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                          topTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(1, 2),
                              FlSpot(2, 2),
                              FlSpot(3, 10),
                              FlSpot(4, 4),
                              FlSpot(5, 20),
                              FlSpot(6, 4),
                              FlSpot(8, 15),
                              FlSpot(9, 9),
                              FlSpot(10, 1),
                            ],
                            barWidth: 4,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(36, 216, 204, 1),
                                  Color.fromRGBO(13, 227, 98, 1),
                                  Color.fromRGBO(235, 223, 53, 1),
                                ])),
                            aboveBarData: BarAreaData(
                              show: true,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          // glycemic index
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            padding:
                const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(text: "Glycemic Index", style: 'labelLarge'),
                Divider(color: Colors.grey[400]),
                const SizedBox(
                  height: 10,
                ),
                AspectRatio(
                  aspectRatio: 2.0,
                  child: LineChart(
                    LineChartData(
                        borderData: FlBorderData(
                            border: const Border(
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide.none,
                                top: BorderSide.none)),
                        // gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                          rightTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                          topTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(1, 17),
                              FlSpot(2, 5),
                              FlSpot(3, 11),
                              FlSpot(4, 26),
                              FlSpot(5, 21),
                              FlSpot(6, 7),
                              FlSpot(8, 1),
                              FlSpot(9, 18),
                              FlSpot(10, 29),
                            ],
                            barWidth: 4,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(36, 216, 204, 1),
                                  Color.fromRGBO(13, 227, 98, 1),
                                  Color.fromRGBO(235, 223, 53, 1),
                                ])),
                            aboveBarData: BarAreaData(
                              show: true,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          // diet diversity score
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            padding:
                const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(text: "Glycemic Index", style: 'labelLarge'),
                Divider(color: Colors.grey[400]),
                const SizedBox(
                  height: 10,
                ),
                AspectRatio(
                  aspectRatio: 2.0,
                  child: LineChart(
                    LineChartData(
                        borderData: FlBorderData(
                            border: const Border(
                                right: BorderSide.none,
                                left: BorderSide.none,
                                bottom: BorderSide.none,
                                top: BorderSide.none)),
                        // gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                          rightTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                          topTitles: AxisTitles(
                              drawBelowEverything: false, axisNameSize: 10),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(1, 17),
                              FlSpot(2, 5),
                              FlSpot(3, 11),
                              FlSpot(4, 26),
                              FlSpot(5, 21),
                              FlSpot(6, 7),
                              FlSpot(8, 1),
                              FlSpot(9, 18),
                              FlSpot(10, 29),
                            ],
                            barWidth: 4,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            belowBarData: BarAreaData(
                                show: true,
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(36, 216, 204, 1),
                                  Color.fromRGBO(13, 227, 98, 1),
                                  Color.fromRGBO(235, 223, 53, 1),
                                ])),
                            aboveBarData: BarAreaData(
                              show: true,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("History",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/historyAll'),
                    },
                    child: Row(
                      children: [
                        Text("View all",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
          )
        ]),
      )),
    );
  }
}
