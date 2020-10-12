import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'drawer/drawer.dart';

class MyScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool hasDrawer;
  final List<Tab> tabs;
  final List<Widget> tabViews;

  MyScaffold({
    @required this.title,
    @required this.child,
    this.hasDrawer = true,
    this.tabs,
    this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: tabs != null
            ? TabBar(
                tabs: tabs,
              )
            : null,
      ),
      drawer: hasDrawer ? MyDrawer() : null,
      body: tabs != null
          ? hasDrawer
              ? DoubleBackToCloseApp(
                  child: TabBarView(
                    children: tabViews,
                  ),
                  snackBar: const SnackBar(
                    content: Text('Tap back again to exit.'),
                  ),
                )
              : TabBarView(
                  children: tabViews,
                )
          : hasDrawer
              ? DoubleBackToCloseApp(
                  child: child,
                  snackBar: const SnackBar(
                    content: Text('Tap back again to exit.'),
                  ),
                )
              : child,
    );
  }
}
