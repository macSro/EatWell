import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Settings',
      child: Center(child: const Text('Settings')),
    );
  }
}
