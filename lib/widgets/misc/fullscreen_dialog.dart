import 'package:flutter/material.dart';

import '../../constants.dart';

showFullscreenDialog({
  @required BuildContext context,
  @required Widget child,
  @required String title,
  @required Widget closeButton,
}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.93),
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) {
      return _FullscreenDialog(
        child: child,
        title: title,
        closeButton: closeButton,
      );
    },
  );
}

class _FullscreenDialog extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget closeButton;

  _FullscreenDialog({
    @required this.child,
    @required this.title,
    @required this.closeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
          child: Column(
            children: [
              Center(
                child: Text(
                  '$title',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kPrimaryColorDark, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: child,
              ),
              const SizedBox(height: 16),
              closeButton,
            ],
          ),
        ),
      ),
    );
  }
}
