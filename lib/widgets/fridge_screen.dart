import 'package:flutter/material.dart';
import 'misc/scaffold.dart';

class FridgeScreen extends StatelessWidget {
  static const routeName = '/fridge';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'E-Fridge',
      child: Center(
        child: Text('E-Fridge'),
      ),
    );
  }
}
