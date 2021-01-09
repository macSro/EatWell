import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../misc/scaffold.dart';
import 'create_recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatedRecipesBloc, CreatedRecipesState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Create a new recipe',
          hasDrawer: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                CreateRecipeForm(
                  currentRecipes: state is CreatedRecipesFetched ? state.recipes : [],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
