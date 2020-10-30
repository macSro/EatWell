import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Widget iconButton;
  final Color color;

  CircleIconButton({@required this.iconButton, @required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            height: 48,
            width: 48,
          ),
          iconButton,
        ],
      ),
    );
  }
}
