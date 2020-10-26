import 'package:flutter/material.dart';

typedef void ChangingIconButtonCallback(bool isPrimary);

class ChangingIconButton extends StatefulWidget {
  final Icon iconPrimary;
  final Icon iconSecondary;
  final ChangingIconButtonCallback onPressed;

  ChangingIconButton(
      {@required this.iconPrimary,
      @required this.iconSecondary,
      @required this.onPressed});

  @override
  _ChangingIconButtonState createState() => _ChangingIconButtonState();
}

class _ChangingIconButtonState extends State<ChangingIconButton> {
  bool isPrimary = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: isPrimary ? widget.iconPrimary : widget.iconSecondary,
      onPressed: () {
        widget.onPressed(isPrimary);
        setState(() {
          isPrimary = !isPrimary;
        });
      },
    );
  }
}
