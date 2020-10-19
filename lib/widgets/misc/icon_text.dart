import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Text text;
  final Icon icon;
  final double spacing;
  final bool iconFirst;

  IconText(
      {@required this.text,
      @required this.icon,
      this.spacing = 8,
      this.iconFirst = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconFirst ? icon : text,
        SizedBox(width: spacing),
        iconFirst ? text : icon,
      ],
    );
  }
}
