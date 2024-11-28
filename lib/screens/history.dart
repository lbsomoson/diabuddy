import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record/record_bloc.dart';
import 'package:diabuddy/widgets/history_row.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  User? user;

  @override
  void initState() {
    super.initState();

    user = context.read<UserAuthProvider>().user;
    if (user != null) {
      context.read<RecordBloc>().add(LoadRecords(user!.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextWidget(text: "Statistics", style: 'bodyLarge')),
      body: SafeArea(
          child: SingleChildScrollView(
              child: BlocListener<RecordBloc, RecordState>(listener: (context, state) {
        if (state is RecordUpdated) context.read<RecordBloc>().add(LoadRecords(user!.uid));
      }, child: BlocBuilder<RecordBloc, RecordState>(
        builder: (context, state) {
          if (state is RecordLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecordLoaded) {
            List<DailyHealthRecord> records = state.records;
            if (records.isEmpty) return const Center(child: Text("No records found."));
            return buildScreen(records);
          } else if (state is RecordNotFound) {
            return const Center(child: Text("No records available."));
          } else if (state is RecordError) {
            return const Center(child: Text("Failed to load records."));
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      )))),
    );
  }

  // Widget buildChartContainer(String title, double value) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: Colors.grey[200],
  //     ),
  //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         TextWidget(text: title, style: 'labelLarge'),
  //         Divider(color: Colors.grey[400]),
  //         const SizedBox(height: 10),
  //         AspectRatio(
  //           aspectRatio: 2.0,
  //           child: LineChart(
  //             LineChartData(
  //               borderData: FlBorderData(
  //                 border: const Border(
  //                   right: BorderSide.none,
  //                   left: BorderSide.none,
  //                   bottom: BorderSide.none,
  //                   top: BorderSide.none,
  //                 ),
  //               ),
  //               titlesData: FlTitlesData(
  //                 bottomTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     interval: 1, // Ensure each X-axis point has a title
  //                     getTitlesWidget: (value, meta) {
  //                       switch (value.toInt()) {
  //                         case 1:
  //                           return const Text(
  //                             "MON",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 2:
  //                           return const Text(
  //                             "TUE",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 3:
  //                           return const Text(
  //                             "WED",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 4:
  //                           return const Text(
  //                             "THU",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 5:
  //                           return const Text(
  //                             "FRI",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 6:
  //                           return const Text(
  //                             "SAT",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         case 7:
  //                           return const Text(
  //                             "SUN",
  //                             style: TextStyle(fontSize: 12),
  //                           );
  //                         default:
  //                           return const Text("");
  //                       }
  //                     },
  //                   ),
  //                 ),
  //                 leftTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     interval: 100,
  //                     getTitlesWidget: (value, meta) {
  //                       if (value % 100 == 0) {
  //                         return Text(
  //                           "${value.toInt()}",
  //                           style: const TextStyle(fontSize: 12),
  //                         );
  //                       }
  //                       return const SizedBox.shrink();
  //                     },
  //                   ),
  //                 ),
  //                 rightTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
  //                 topTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
  //               ),
  //               lineBarsData: [
  //                 LineChartBarData(
  //                   spots: [
  //                     FlSpot(1, value),
  //                     FlSpot(2, 380),
  //                     FlSpot(3, 400),
  //                     FlSpot(4, 336),
  //                     FlSpot(5, 184),
  //                     FlSpot(6, 560),
  //                     FlSpot(7, 250),
  //                   ],
  //                   barWidth: 4,
  //                   isCurved: true,
  //                   preventCurveOverShooting: true,
  //                   belowBarData: BarAreaData(
  //                     show: true,
  //                     gradient: const LinearGradient(
  //                       colors: [
  //                         Color.fromRGBO(36, 216, 204, 1),
  //                         Color.fromRGBO(13, 227, 98, 1),
  //                         Color.fromRGBO(235, 223, 53, 1),
  //                       ],
  //                     ),
  //                   ),
  //                   aboveBarData: BarAreaData(show: true),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildChartContainer(String title, List<FlSpot> spots) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: title, style: 'labelLarge'),
          Divider(color: Colors.grey[400]),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 2.0,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(
                  border: const Border(
                    right: BorderSide.none,
                    left: BorderSide.none,
                    bottom: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "Day ${value.toInt()}",
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 50,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
                  topTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    barWidth: 4,
                    isCurved: true,
                    preventCurveOverShooting: true,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(36, 216, 204, 1),
                          Color.fromRGBO(13, 227, 98, 1),
                          Color.fromRGBO(235, 223, 53, 1),
                        ],
                      ),
                    ),
                    aboveBarData: BarAreaData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreen(List<DailyHealthRecord> records) {
    // Group records by date
    Map<String, List<DailyHealthRecord>> groupedRecords = {};
    for (var record in records) {
      String dateKey = record.date.toString().split(' ')[0]; // Group by date (YYYY-MM-DD)
      groupedRecords.putIfAbsent(dateKey, () => []).add(record);
    }

    // Prepare chart data
    List<FlSpot> calorieSpots = [];
    List<FlSpot> glycemicIndexSpots = [];
    List<FlSpot> diversityScoreSpots = [];
    int dayCounter = 1;

    for (var entry in groupedRecords.entries) {
      String date = entry.key;
      List<DailyHealthRecord> dailyRecords = entry.value;

      // Aggregate data
      double totalCalories = dailyRecords.fold(0, (sum, record) => sum + record.energyKcal);
      double averageGlycemicIndex = dailyRecords.isNotEmpty
          ? dailyRecords.fold(0, (sum, record) => sum + record.glycemicIndex.toInt()) / dailyRecords.length
          : 0;
      double averageDiversityScore = dailyRecords.isNotEmpty
          ? dailyRecords.fold(0, (sum, record) => sum + record.diversityScore.toInt()) / dailyRecords.length
          : 0;

      // Add spots for charts
      calorieSpots.add(FlSpot(dayCounter.toDouble(), totalCalories));
      glycemicIndexSpots.add(FlSpot(dayCounter.toDouble(), averageGlycemicIndex));
      diversityScoreSpots.add(FlSpot(dayCounter.toDouble(), averageDiversityScore));

      dayCounter++;
    }

    // Build charts
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildChartContainer("Calories (kCal)", calorieSpots),
        buildChartContainer("Glycemic Index", glycemicIndexSpots),
        buildChartContainer("Diet Diversity Score", diversityScoreSpots),
      ],
    );
  }

  // Widget buildScreen(List<DailyHealthRecord> records) {
  //   // Group records by date
  //   Map<String, List<DailyHealthRecord>> groupedRecords = {};
  //   for (var record in records) {
  //     String dateKey = record.date.toString().split(' ')[0]; // Group by date (YYYY-MM-DD)
  //     groupedRecords.putIfAbsent(dateKey, () => []).add(record);
  //   }

  //   return Column(
  //     children: groupedRecords.entries.map((entry) {
  //       String date = entry.key;
  //       List<DailyHealthRecord> dailyRecords = entry.value;

  //       // Calculate daily totals or averages for charts
  //       double totalCalories = dailyRecords.fold(0, (sum, record) => sum + record.energyKcal);
  //       double averageGlycemicIndex = dailyRecords.isNotEmpty
  //           ? dailyRecords.fold(0, (sum, record) => sum + record.glycemicIndex.toInt()) / dailyRecords.length
  //           : 0;
  //       double averageDiversityScore = dailyRecords.isNotEmpty
  //           ? dailyRecords.fold(0, (sum, record) => sum + record.diversityScore.toInt()) / dailyRecords.length
  //           : 0;

  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: TextWidget(text: "Date: $date", style: 'bodyLarge'),
  //           ),
  //           buildChartContainer("Calories", totalCalories),
  //           buildChartContainer("Glycemic Index", averageGlycemicIndex),
  //           buildChartContainer("Diet Diversity Score", averageDiversityScore),
  //         ],
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildScreen2() {
    return Column(children: [
      // calories
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        padding: const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(text: "Calories (in kCal)", style: 'labelLarge'),
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
                      rightTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
                      topTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        padding: const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
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
                      rightTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
                      topTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
        padding: const EdgeInsets.only(top: 20, right: 25, bottom: 15, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(text: "Diet Diversity Score", style: 'labelLarge'),
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
                      rightTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
                      topTitles: AxisTitles(drawBelowEverything: false, axisNameSize: 10),
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
    ]);
  }
}
