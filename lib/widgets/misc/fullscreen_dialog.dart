import 'package:flutter/material.dart';

showFullscreenDialog({@required BuildContext context, @required child}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.93),
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) {
      return _FullscreenDialog(child: child);
    },
  );
}

class _FullscreenDialog extends StatelessWidget {
  final Widget child;

  _FullscreenDialog({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: child,
        ),
      ),
    );
  }
}
