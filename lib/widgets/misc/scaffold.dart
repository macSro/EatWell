import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'drawer/drawer.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final bool hasAppBar;
  final String title;
  final bool hasDrawer;
  final TabBar tabBar;
  final List<Widget> tabViews;
  final Widget floatingActionButton;

  MyScaffold({
    @required this.child,
    this.hasAppBar = true,
    this.title,
    this.hasDrawer = true,
    this.tabBar,
    this.tabViews,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hasAppBar
          ? AppBar(
              title: Text(title),
              bottom: tabBar,
            )
          : null,
      drawer: hasDrawer ? MyDrawer() : null,
      floatingActionButton: floatingActionButton,
      body: tabBar != null
          ? hasDrawer
              ? DoubleBackToCloseApp(
                  child: TabBarView(
                    children: tabViews,
                  ),
                  snackBar: const SnackBar(
                    content: const Text('Tap back again to exit.'),
                  ),
                )
              : TabBarView(
                  children: tabViews,
                )
          : hasDrawer
              ? DoubleBackToCloseApp(
                  child: child,
                  snackBar: const SnackBar(
                    content: const Text('Tap back again to exit.'),
                  ),
                )
              : child,
    );
  }
}
