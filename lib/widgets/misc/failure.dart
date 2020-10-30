import 'package:flutter/material.dart';

import '../../constants.dart';

class FailureView extends StatelessWidget {
  final String message;

  FailureView({this.message = kErrorOccurredMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            'Please try again.',
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
    );
  }
}
