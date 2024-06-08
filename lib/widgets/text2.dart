import 'package:flutter/material.dart';

class Text2Widget extends StatefulWidget {
  final String text, style;
  final int? maxLines;
  const Text2Widget(
      {required this.text, required this.style, this.maxLines, super.key});

  @override
  State<Text2Widget> createState() => _Text2WidgetState();
}

class _Text2WidgetState extends State<Text2Widget> {
  // screen title
  TextStyle bodyLarge = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(100, 204, 197, 1),
    fontFamily: 'Inter',
  );

  // title
  TextStyle bodyMedium = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color.fromRGBO(100, 204, 197, 1),
    fontFamily: 'Inter',
  );

  // caption
  TextStyle bodySmall = TextStyle(
    color: Colors.grey[500],
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Inter',
  );

  // section header
  TextStyle sectionHeader = const TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w800,
    fontFamily: 'Inter',
  );

  // section header 2
  TextStyle sectionHeader2 = const TextStyle(
    color: Color.fromRGBO(100, 204, 197, 1),
    fontSize: 18,
    fontWeight: FontWeight.w800,
    fontFamily: 'Inter',
  );

  // text field helper
  TextStyle labelMedium = TextStyle(
    color: Colors.grey[500],
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
  );

  TextStyle titleSmall = TextStyle(
    color: Colors.grey[500],
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );

  // button
  TextStyle labelLarge = const TextStyle(
    color: Colors.white,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
  );

  // body
  TextStyle body = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  // body2
  TextStyle body2 = const TextStyle(
    color: Color.fromRGBO(100, 204, 197, 1),
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );

  // body3
  TextStyle body3 = const TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  // body4
  TextStyle body4 = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );
  //body5
  TextStyle body5 = const TextStyle(
    color: Colors.grey,
    fontSize: 10,
    fontWeight: FontWeight.w200,
    fontFamily: 'Inter',
  );
  //body5
  TextStyle body6 = const TextStyle(
    color: Color.fromRGBO(100, 204, 197, 1),
    fontSize: 10,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      maxLines: widget.maxLines ?? 3,
      textAlign: TextAlign.justify,
      style: switch (widget.style) {
        'sectionHeader' => sectionHeader,
        'sectionHeader2' => sectionHeader2,
        'bodySmall' => bodySmall,
        'bodyMedium' => bodyMedium,
        'bodyLarge' => bodyLarge,
        'labelMedium' => labelMedium,
        'labelLarge' => labelLarge,
        'titleSmall' => titleSmall,
        'body' => body,
        'body2' => body2,
        'body3' => body3,
        'body4' => body4,
        'body5' => body5,
        'body6' => body6,
        _ => Theme.of(context).textTheme.bodyMedium,
      },
    );
  }
}
