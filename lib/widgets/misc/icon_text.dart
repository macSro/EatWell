import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final Text text;
  final Icon icon;
  final double spacing;
  final bool iconFirst;
  final bool squeeze;
  final bool center;

  IconText({
    @required this.text,
    @required this.icon,
    this.spacing = 8,
    this.iconFirst = true,
    this.squeeze = false,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: squeeze ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        iconFirst ? icon : text,
        SizedBox(width: spacing),
        iconFirst ? text : icon,
      ],
    );
  }
}
