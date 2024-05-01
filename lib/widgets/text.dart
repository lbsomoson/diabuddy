import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text, style;
  const TextWidget({required this.text, required this.style, super.key});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 3,
      style: switch (widget.style) {
        'bodySmall' => Theme.of(context).textTheme.bodySmall,
        'bodyMedium' => Theme.of(context).textTheme.bodyMedium,
        'bodyLarge' => Theme.of(context).textTheme.bodyLarge,
        'titleSmall' => Theme.of(context).textTheme.titleSmall,
        _ => Theme.of(context).textTheme.bodyMedium,
      },
    );
  }
}
