import 'package:flutter/material.dart';

typedef void ChangingIconButtonCallback(bool isPrimary);

class ChangingIconButton extends StatefulWidget {
  final Icon iconPrimary;
  final Icon iconSecondary;
  final ChangingIconButtonCallback onPressed;
  final bool initState;

  ChangingIconButton({
    @required this.iconPrimary,
    @required this.iconSecondary,
    @required this.onPressed,
    @required this.initState,
  });

  @override
  _ChangingIconButtonState createState() => _ChangingIconButtonState();
}

class _ChangingIconButtonState extends State<ChangingIconButton> {
  bool isPrimary;

  @override
  void initState() {
    isPrimary = widget.initState;
    super.initState();
  }

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
