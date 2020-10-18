import 'package:flutter/material.dart';

import 'misc/scaffold.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Custom filters',
      child: Center(child: const Text('Diets')),
    );
  }
}
