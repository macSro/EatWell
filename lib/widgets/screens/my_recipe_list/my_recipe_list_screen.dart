import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

import 'created_recipe_list_screen.dart';
import 'saved_recipe_list_screen.dart';

class MyRecipeListScreen extends StatelessWidget {
  static const routeName = '/my-recipe-list';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MyScaffold(
        title: 'My recipes',
        tabs: [
          Tab(
            icon: Icon(Icons.favorite_rounded),
            text: 'Saved',
          ),
          Tab(
            icon: Icon(Icons.cloud_upload_rounded),
            text: 'Created',
          ),
        ],
        tabViews: [
          SavedRecipeListScreen(),
          CreatedRecipeListScreen(),
        ],
        child: Container(),
      ),
    );
  }
}
