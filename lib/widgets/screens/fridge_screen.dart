import 'package:flutter/material.dart';

import '../misc/scaffold.dart';

class PantryScreen extends StatelessWidget {
  static const routeName = '/pantry';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Pantry',
      child: Center(
        child: const Text('Pantry'),
      ),
    );
  }
}
