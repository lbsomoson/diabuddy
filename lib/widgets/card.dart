import 'package:diabuddy/widgets/text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String title, subtitle;
  final double? size;
  final Function? callback;
  final IconData? leading, trailing;
  // final FontAwesomeIconData? leadingAwesome;

  const CardWidget(
      {required this.title,
      required this.subtitle,
      this.size,
      this.callback,
      this.trailing,
      // this.leadingAwesome,
      this.leading,
      super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: ListTile(
          contentPadding: const EdgeInsets.only(right: 1),
          leading: widget.leading != null
              ? Icon(
                  widget.leading!,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
          trailing: widget.trailing != null
              ? IconButton(
                  icon: Icon(
                    widget.trailing!,
                    size: widget.size ?? 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    if (widget.callback != null) {
                      widget.callback!();
                    }
                  },
                )
              : null,
          title: TextWidget(text: widget.title, style: 'bodyMedium'),
          subtitle: TextWidget(text: widget.subtitle, style: 'bodySmall'),
        ),
      ),
    );
  }
}
