import 'package:flutter/material.dart';

class AuthenticatedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Authentication has failed!',
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.red),
      ),
    );
  }
}
