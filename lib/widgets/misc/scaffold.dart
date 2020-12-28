import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/recipes/recipe_list_bloc.dart';
import '../../bloc/recipes/recipe_list_event.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../screens/login/login_screen.dart';
import 'drawer/drawer.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final bool hasAppBar;
  final String title;
  final bool hasDrawer;
  final TabBar tabBar;
  final List<Widget> tabViews;
  final Widget floatingActionButton;
  final List<Widget> actions;

  MyScaffold({
    @required this.child,
    this.hasAppBar = true,
    this.title,
    this.hasDrawer = true,
    this.tabBar,
    this.tabViews,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) => previous is UserLoading && current is UserUnauthenticated,
      listener: (context, state) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: hasAppBar
              ? AppBar(
                  title: Text(title),
                  actions: actions,
                  bottom: tabBar,
                )
              : null,
          drawer: hasDrawer
              ? BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) => state is UserAuthenticated
                      ? state.userDisplayName != null && state.userDisplayName != ''
                          ? MyDrawer(userDisplayName: state.userDisplayName)
                          : MyDrawer()
                      : MyDrawer(),
                )
              : null,
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
        ),
      ),
    );
  }
}
