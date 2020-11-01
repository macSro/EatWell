import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error';

  final String message;

  ErrorScreen({this.message = kErrorOccurredMessage});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      hasAppBar: false,
      hasDrawer: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Center(
            child: Text(
              kErrorOccurredMessage,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const SizedBox(height: 32),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Text(
              'Close',
              style: TextStyle().copyWith(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
