import 'package:flutter/material.dart';

import '../../constants.dart';

Future showFullscreenDialog({
  @required BuildContext context,
  @required Widget child,
  @required String title,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.93),
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) {
      return _FullscreenDialog(
        child: child,
        title: title,
      );
    },
  );
}

class _FullscreenDialog extends StatelessWidget {
  final Widget child;
  final String title;

  _FullscreenDialog({@required this.child, @required this.title});

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
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: child,
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 16),
                child: RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Close',
                        style: TextStyle().copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
