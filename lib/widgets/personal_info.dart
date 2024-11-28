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

  void showPhysicalActivityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
            title: Text("Physical Activity Factor"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Sedentary",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 54, 74, 1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Text(
                                "Less than 5,000 steps daily.",
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 54, 74, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Roboto',
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Mostly resting with little or no activity.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 20,
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Light",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 54, 74, 1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Text(
                                "About 5,000 to 7,499 steps daily.",
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 54, 74, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Roboto',
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Occupations that require minimal movement, mostly sitting/desk work or standing for long hours and/or with occasional walking (professional, clerical, technical workers, administrative and managerial staff, driving light vehicles (cars, jeepney). Housewives with light housework (dishwashing, preparing food).",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 20,
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Moderate",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 54, 74, 1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Text(
                                "About 7,500 to 9,999 steps daily.",
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 54, 74, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Roboto',
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Occupations that require extended periods of walking, pushing or pulling or lifting or carrying heavy objects (cleaning/domestic services, waiting table, homebuilding task, farming, patient care).",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 20,
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Very Active or Vigorous",
                                  style: TextStyle(
                                      color: Color.fromRGBO(4, 54, 74, 1),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                              Text(
                                "More than 10,000 steps daily.",
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 54, 74, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Roboto',
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Occupations that require extensive periods of running, rapid movement, pushing or pulling heavy objects or tasks frequently requiring strenuous effort and extensive total body movements (teaching a class or skill requiring active and strenuous participation, such as aerobics or physical education instructor; firefighting; masonry and heavy construction work; coal mining; manually shoveling, using heavy non-powered tools).",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Roboto',
                            ),
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            maxLines: 20,
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  )
                ],
              ),
            ));
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
                          widget.title == "BMI"
                              ? showCustomDialog(context)
                              : widget.title == "Activity"
                                  ? showPhysicalActivityDialog(context)
                                  : null;
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
