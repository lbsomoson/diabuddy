import 'package:diabuddy/models/daily_health_record_model.dart';
import 'package:diabuddy/provider/auth_provider.dart';
import 'package:diabuddy/provider/daily_health_record_provider.dart';
import 'package:diabuddy/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedView = 2;

  @override
  Widget build(BuildContext context) {
    User? user = context.read<UserAuthProvider>().user;
    Future<List<DailyHealthRecord>> allRecords = context.watch<DailyHealthRecordProvider>().getAllRecords(user!.uid);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Statistics", style: 'bodyLarge'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<DailyHealthRecord>>(
          future: allRecords,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final records = snapshot.data!;
              if (records.isEmpty) {
                return const Center(child: Text("No records found."));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSegmentedControl(),
                    const SizedBox(height: 16),
                    if (selectedView == 1) _buildDailyView(records),
                    if (selectedView == 2) _buildWeeklyView(records),
                    if (selectedView == 3) _buildMonthlyView(records),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No data available."));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return CustomSlidingSegmentedControl<int>(
      initialValue: selectedView,
      children: const {
        1: Text('Daily'),
        2: Text('Weekly'),
        3: Text('Monthly'),
      },
      decoration: BoxDecoration(
        color: CupertinoColors.lightBackgroundGray,
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      onValueChanged: (value) {
        setState(() {
          selectedView = value;
        });
      },
    );
  }

  Widget _buildDailyView(List<DailyHealthRecord> records) {
    return _buildDataTable(records, "Daily");
  }

  Widget _buildWeeklyView(List<DailyHealthRecord> records) {
    return _buildDataTable(records, "Weekly");
  }

  Widget _buildMonthlyView(List<DailyHealthRecord> records) {
    return _buildDataTable(records, "Monthly");
  }

  Widget _buildDataTable(List<DailyHealthRecord> records, String title) {
    List<Map<String, dynamic>> aggregatedData;

    if (title == "Monthly") {
      aggregatedData = calculateMonthlyTotals(records);
    } else if (title == "Weekly") {
      aggregatedData = calculateWeeklyTotals(records);
    } else {
      aggregatedData = calculateOtherTotals(records);
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columnSpacing: 35,
            dividerThickness: 0.5,
            columns: [
              DataColumn(
                tooltip: 'Date',
                label: Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const DataColumn(
                tooltip: 'Calories',
                label: Text(
                  'kCal',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(4, 54, 74, 1),
                  ),
                ),
              ),
              const DataColumn(
                tooltip: 'Glycemic Index',
                label: Text(
                  'GI',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(4, 54, 74, 1),
                  ),
                ),
              ),
              const DataColumn(
                tooltip: 'Diversity Score',
                label: Text(
                  'DS',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(4, 54, 74, 1),
                  ),
                ),
              ),
              const DataColumn(
                tooltip: 'Healthy Eating Index',
                label: Text(
                  'HEI',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(4, 54, 74, 1),
                  ),
                ),
              ),
            ],
            rows: aggregatedData
                .map(
                  (r) => DataRow(
                    cells: [
                      DataCell(Text(
                        title == "Monthly"
                            ? getMonth(r['month'] as int)
                            : title == "Weekly"
                                ? r['month']
                                : r['date'],
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                      DataCell(Text(
                        r['energyKcal'].toStringAsFixed(2),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r['glycemicIndex'].toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r['diversityScore'].toStringAsFixed(0),
                        style: const TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
                      )),
                      DataCell(Text(
                        r['healthyEatingIndex'].toStringAsFixed(0),
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

  List<Map<String, dynamic>> calculateOtherTotals(List<DailyHealthRecord> records) {
    return records.map((record) {
      return {
        'date': getMonthDate(record.date.month, record.date.day),
        'energyKcal': record.energyKcal,
        'glycemicIndex': record.glycemicIndex,
        'diversityScore': record.diversityScore,
        'healthyEatingIndex': record.healthyEatingIndex,
      };
    }).toList();
  }

  List<Map<String, dynamic>> calculateWeeklyTotals(List<DailyHealthRecord> records) {
    Map<String, Map<String, dynamic>> weeklyTotals = {};

    // Define the weeks within a month
    List<int> weekStarts = [1, 8, 15, 22];

    // Loop through all the records and group them by weeks
    for (var record in records) {
      // Extract the month and day from the record's date
      int month = record.date.month;
      int day = record.date.day;

      // Determine which week the day belongs to
      int weekIndex = 0;
      for (int i = 0; i < weekStarts.length; i++) {
        if (day >= weekStarts[i]) {
          weekIndex = i;
        }
      }

      // Create a week label, e.g., "Nov, Week 1"
      String weekLabel = '${getMonth(month)}, W${weekIndex + 1}';

      // Initialize the week entry in the map if not already present
      if (!weeklyTotals.containsKey(weekLabel)) {
        weeklyTotals[weekLabel] = {
          'healthyEatingIndex': 0.0,
          'diversityScore': 0.0,
          'glycemicIndex': 0.0,
          'energyKcal': 0.0,
          'month': weekLabel, // Store month separately
        };
      }

      // Access the existing map for the week and safely update the values
      var weekTotals = weeklyTotals[weekLabel]!;

      weekTotals['healthyEatingIndex'] = (weekTotals['healthyEatingIndex'] ?? 0.0) + record.healthyEatingIndex;
      weekTotals['diversityScore'] = (weekTotals['diversityScore'] ?? 0.0) + record.diversityScore;
      weekTotals['glycemicIndex'] = (weekTotals['glycemicIndex'] ?? 0.0) + record.glycemicIndex;
      weekTotals['energyKcal'] = (weekTotals['energyKcal'] ?? 0.0) + record.energyKcal;
    }

    // Convert the aggregated map into a List<Map<String, dynamic>>
    return weeklyTotals.entries.map((entry) {
      return {
        'week': entry.key,
        'energyKcal': entry.value['energyKcal']!,
        'glycemicIndex': entry.value['glycemicIndex']!,
        'diversityScore': entry.value['diversityScore']!,
        'healthyEatingIndex': entry.value['healthyEatingIndex']!,
        'month': entry.value['month'],
      };
    }).toList();
  }

  List<Map<String, dynamic>> calculateMonthlyTotals(List<DailyHealthRecord> records) {
    // create a list to hold aggregated monthly data
    List<Map<String, dynamic>> monthlyTotals = [];

    Map<String, Map<String, double>> tempTotals = {};

    for (var record in records) {
      // Extract year and month as a key (e.g., "2024-11")
      String monthKey = "${record.date.year}-${record.date.month.toString().padLeft(2, '0')}";

      if (!tempTotals.containsKey(monthKey)) {
        tempTotals[monthKey] = {
          'healthyEatingIndex': 0.0,
          'diversityScore': 0.0,
          'glycemicIndex': 0.0,
          'energyKcal': 0.0,
        };
      }

      var monthTotals = tempTotals[monthKey]!;

      monthTotals['healthyEatingIndex'] = (monthTotals['healthyEatingIndex'] ?? 0.0) + record.healthyEatingIndex;
      monthTotals['diversityScore'] = (monthTotals['diversityScore'] ?? 0.0) + record.diversityScore;
      monthTotals['glycemicIndex'] = (monthTotals['glycemicIndex'] ?? 0.0) + record.glycemicIndex;
      monthTotals['energyKcal'] = (monthTotals['energyKcal'] ?? 0.0) + record.energyKcal;
    }

    // Convert to a list format for easier use in DataTable
    tempTotals.forEach((monthKey, totals) {
      var dateParts = monthKey.split('-');
      monthlyTotals.add({
        'month': int.parse(dateParts[1]),
        'day': 1, // Arbitrary value for display
        'healthyEatingIndex': totals['healthyEatingIndex'],
        'diversityScore': totals['diversityScore'],
        'glycemicIndex': totals['glycemicIndex'],
        'energyKcal': totals['energyKcal'],
      });
    });

    return monthlyTotals;
  }

  String getMonth(int month) {
    List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];
    String monthString = monthNames[month - 1];
    return monthString;
  }

  String getMonthDate(int month, int day) {
    List<String> monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"];
    String monthString = monthNames[month - 1];
    return '$monthString $day';
  }
}
