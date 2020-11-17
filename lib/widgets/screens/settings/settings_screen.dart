import 'package:flutter/material.dart';

import '../../misc/scaffold.dart';

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
