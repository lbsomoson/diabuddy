import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatefulWidget {
  final String title, value;
  final IconData? icon;
  const PersonalInformation({required this.title, required this.value, this.icon, super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Asia-Pacific BMI Classification"),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      'BMI',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'Nutritional Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                  ],
                  rows: const [
                    DataRow(cells: [DataCell(Text('Underweight')), DataCell(Text('< 18.5'))]),
                    DataRow(cells: [DataCell(Text('Normal')), DataCell(Text('18.5 - 22.9'))]),
                    DataRow(cells: [DataCell(Text('Overweight')), DataCell(Text('23 - 24.9'))]),
                    DataRow(cells: [DataCell(Text('Obese')), DataCell(Text('\u2265 25'))]),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: Row(
              children: [
                TextWidget(text: widget.title, style: 'labelLarge'),
                const SizedBox(
                  width: 5,
                ),
                widget.icon != null
                    ? GestureDetector(
                        onTap: () {
                          showCustomDialog(context);
                        },
                        child: Icon(
                          widget.icon!,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : Container()
              ],
            )),
        Expanded(
            flex: 5,
            child: Row(
              children: [
                TextWidget(text: widget.value, style: 'bodySmall'),
              ],
            )),
      ],
    );
  }
}
