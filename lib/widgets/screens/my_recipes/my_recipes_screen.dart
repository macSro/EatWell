import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/widgets/misc/failure.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'created_recipes_screen.dart';
import 'saved_recipes_screen.dart';

class MyRecipesScreen extends StatelessWidget {
  static const routeName = '/my-recipes';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => state is UserAuthenticated
          ? DefaultTabController(
              length: 2,
              child: MyScaffold(
                title: 'My recipes',
                tabBar: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.cloud_upload_rounded),
                      text: 'Created',
                    ),
                    Tab(
                      icon: Icon(Icons.favorite_rounded),
                      text: 'Saved',
                    ),
                  ],
                ),
                tabViews: [
                  CreatedRecipesScreen(),
                  SavedRecipesScreen(),
                ],
                child: Container(),
              ),
            )
          : FailureView(),
    );
  }
}
