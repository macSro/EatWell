import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../bloc/recipes/recipe_list_bloc.dart';
import '../../../bloc/recipes/recipe_list_state.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_state.dart';
import '../../../model/recipe.dart';
import '../../misc/fullscreen_dialog.dart';
import '../../misc/loading.dart';
import '../../misc/scaffold.dart';
import '../filters/filter_list.dart';
import '../recipe/recipe_screen.dart';
import 'recipe_list.dart';
import 'recipe_list_item.dart';

class RecipesScreen extends StatelessWidget {
  static const routeName = '/recipes';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Recipes',
          child: state is RecipesFetched
              ? _getContent(context, state.recipes)
              : LoadingView(text: 'Loading recipes...'),
          floatingActionButton: state is RecipesFetched
              ? FloatingActionButton(
                  onPressed: () {
                    showFullscreenDialog(
                      context: context,
                      child: FilterList(),
                    );
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
        recipeItems: state is UserAuthenticated
            ? _mapRecipesToRecipeItems(context, recipes)
            : [],
      ),
    );
  }

  _mapRecipesToRecipeItems(context, List<Recipe> recipes) {
    return recipes
        .map((recipe) => RecipeListItem(
              recipe: recipe,
              onTap: () => _navigateToRecipeScreen(context, recipe),
            ))
        .toList();
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      FetchRecipeDetails(recipe: recipe),
    );
  }
}
