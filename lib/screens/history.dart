import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record_provider.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user;
    Future<List<DailyHealthRecord>> allRecords = context.watch<DailyHealthRecordProvider>().getAllRecords(user!.uid);

    return Scaffold(
        appBar: AppBar(title: const TextWidget(text: "Statistics", style: 'bodyLarge')),
        body: SafeArea(
            child: SingleChildScrollView(
          child: FutureBuilder(
              future: allRecords,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No records found this month"),
                    );
                  }
                  return buildScreen(snapshot.data!);
                } else {
                  return Container();
                }
              }),
        )));
  }

  Widget buildScreen(List<DailyHealthRecord> records) {
    return Center(
      child: Column(
        children: [
          DataTable(
            dividerThickness: 0.5,
            columns: [
              DataColumn(
                  label: Text(
                'Date',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              )),
              const DataColumn(
                  label: Text(
                'kCal',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(4, 54, 74, 1),
                ),
              )),
              const DataColumn(
                  label: Text(
                'GI',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(4, 54, 74, 1),
                ),
              )),
              const DataColumn(
                  label: Text(
                'DS',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(4, 54, 74, 1),
                ),
              )),
              const DataColumn(
                  label: Text(
                'HIS',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(4, 54, 74, 1),
                ),
              )),
            ],
            rows: records
                .map(
                  (r) => DataRow(
                    cells: [
                      DataCell(Text(
                        getMonthDate(r.date.month, r.date.day),
                        style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).primaryColor),
                      )),
                      DataCell(Text(
                        r.energyKcal.toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r.glycemicIndex.toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r.diversityScore.toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r.healthyEatingIndex.toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String getMonthDate(int month, int day) {
    List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];

    // Get the month as a string (1-based index, so subtract 1)
    String monthString = monthNames[month - 1];

    return '$monthString $day';
  }

  // Widget buildChartContainer(
  //   String title,
  //   List<FlSpot> spots,
  //   List<DateTime> xAxisDates,
  // ) {
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
  //                     interval: 1,
  //                     getTitlesWidget: (value, meta) {
  //                       // convert the timestamp back to a readable date for display
  //                       DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
  //                       return Text('${date.day}'); // ${date.month}/
  //                     },
  //                   ),
  //                 ),
  //                 leftTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     interval: 100,
  //                     getTitlesWidget: (value, meta) {
  //                       // if (value % 100 == 0) {}
  //                       return Text(
  //                         "${value.toInt()}",
  //                         style: const TextStyle(fontSize: 12),
  //                       );
  //                       // return const SizedBox.shrink();
  //                     },
  //                   ),
  //                 ),
  //                 rightTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
  //                 topTitles: const AxisTitles(drawBelowEverything: false, axisNameSize: 10),
  //               ),
  //               lineBarsData: [
  //                 LineChartBarData(
  //                   spots: spots,
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

  // Widget buildScreen(List<DailyHealthRecord> records) {
  //   DateTime date = DateTime.now();

  //   // group records by date
  //   Map<String, List<DailyHealthRecord>> groupedRecords = {};
  //   for (var record in records) {
  //     String dateKey = record.date.toString().split(' ')[0]; // group by date (YYYY-MM-DD)
  //     groupedRecords.putIfAbsent(dateKey, () => []).add(record);
  //   }

  //   // prepare chart data
  //   List<FlSpot> calorieSpots = [];
  //   List<FlSpot> glycemicIndexSpots = [];
  //   List<FlSpot> diversityScoreSpots = [];
  //   List<DateTime> xAxisDates = [];

  //   for (var entry in groupedRecords.entries) {
  //     String date = entry.key;
  //     List<DailyHealthRecord> dailyRecords = entry.value;

  //     // aggregate data
  //     double totalCalories = dailyRecords.fold(0, (sum, record) => sum + record.energyKcal);
  //     double totalGlycemicIndex = dailyRecords.fold(0, (sum, record) => sum + record.glycemicIndex);
  //     double totalDiversityScore = dailyRecords.fold(0, (sum, record) => sum + record.diversityScore);

  //     // convert the date to a timestamp for the x-axis
  //     DateTime dateTime = DateTime.parse(date);
  //     xAxisDates.add(dateTime);

  //     // add a FlSpot using the date's timestamp as x
  //     calorieSpots.add(FlSpot(dateTime.millisecondsSinceEpoch.toDouble(), totalCalories));
  //     glycemicIndexSpots.add(FlSpot(dateTime.millisecondsSinceEpoch.toDouble(), totalGlycemicIndex));
  //     diversityScoreSpots.add(FlSpot(dateTime.millisecondsSinceEpoch.toDouble(), totalDiversityScore));
  //   }

  //   // build charts
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Align(
  //           alignment: Alignment.center,
  //           child: Text(
  //             getMonth(date.month),
  //             style: const TextStyle(color: Color.fromRGBO(4, 54, 74, 1), fontSize: 20),
  //           )),
  //       buildChartContainer("Calories", calorieSpots, xAxisDates),
  //       buildChartContainer("Glycemic Index", glycemicIndexSpots, xAxisDates),
  //       buildChartContainer("Diversity Score", diversityScoreSpots, xAxisDates),
  //     ],
  //   );
  // }
}
