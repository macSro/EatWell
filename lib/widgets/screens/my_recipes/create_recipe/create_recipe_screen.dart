import 'package:flutter/material.dart';

import '../../../misc/scaffold.dart';
import 'create_recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Create a new recipe',
      hasDrawer: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CreateRecipeForm(),
          ],
        ),
      ),
    );
  }
}
