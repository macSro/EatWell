import 'package:flutter/material.dart';

import '../misc/scaffold.dart';

class DietScreen extends StatelessWidget {
  static const routeName = '/diet';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Diet',
      child: Center(child: const Text('Diet')),
    );
  }
}
