import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_state.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recipe_list.dart';
import 'recipe_list_search.dart';

class RecipeListScreen extends StatelessWidget {
  static const routeName = '/recipe-list';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Recipes',
          child: state is AllRecipesFetched
              ? _getContent(context, state.recipes)
              : LoadingView(text: 'Loading recipes...'),
          floatingActionButton: state is AllRecipesFetched
              ? FloatingActionButton(
                  onPressed: () {
                    showRecipeSearchDialog(context: context);
                  },
                  child: Icon(Icons.filter_alt_rounded),
                )
              : null,
        );
      },
    );
  }

  Widget _getContent(context, recipes) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => RecipeList(
        recipes: recipes,
        onItemTap: () {
          if (state is UserAuthenticated)
            _fetchRecipe(context, 1, state.user.id);
        },
      ),
    );
  }

  _fetchRecipe(context, recipeId, userId) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context)
        .add(FetchRecipeDetails(recipeId: recipeId, userId: userId));
  }
}
