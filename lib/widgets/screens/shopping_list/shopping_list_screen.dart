import 'package:flutter/material.dart';

import '../../misc/scaffold.dart';

class ShoppingListScreen extends StatelessWidget {
  static const routeName = '/shopping-list';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Shopping list',
      child: Center(
        child: const Text('Shopping list'),
      ),
    );
  }
}
