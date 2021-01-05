import 'package:eat_well_v1/bloc/all_recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_state.dart';
import '../../../constants.dart';
import '../../../model/recipe.dart';
import '../../misc/fullscreen_dialog.dart';
import '../../misc/loading.dart';
import '../../misc/scaffold.dart';
import '../filters/filter_list.dart';
import '../recipe/recipe_screen.dart';
import 'recipe_list_item.dart';

class RecipesScreen extends StatelessWidget {
  static const routeName = '/recipes';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'All recipes',
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => BlocProvider.of<RecipeListBloc>(context).add(FetchRecipes())),
          ],
          child: state is RecipesFetched
              ? _getContent(context, state.recipes)
              : LoadingView(text: 'Loading recipes...'),
          floatingActionButton: state is RecipesFetched
              ? FloatingActionButton(
                  onPressed: () {
                    showFullscreenDialog(
                      context: context,
                      child: FilterList(),
                      title: 'What are you craving?',
                    ).then(
                      (value) {
                        if (value != null) _applySortByAndFilters(context, state.recipes, value);
                      },
                    );
                  },
                  child: Icon(Icons.filter_alt_rounded),
                )
              : null,
        );
      },
    );
  }

  _applySortByAndFilters(context, recipes, value) {
    final SortBy selectedSortBy = value[0];
    BlocProvider.of<RecipeListBloc>(context).add(
      SortRecipes(recipes: recipes, sortBy: selectedSortBy),
    );
  }

  Widget _getContent(context, recipes) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => ListView(
        children: state is UserAuthenticated ? _mapRecipesToRecipeItems(context, recipes) : [],
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
      SelectRecipe(recipe: recipe),
    );
  }
}
