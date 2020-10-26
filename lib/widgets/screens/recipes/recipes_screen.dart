import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_state.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipe_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'recipe_list.dart';
import 'recipe_list_search.dart';

class RecipesScreen extends StatelessWidget {
  static const routeName = '/recipes';

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
        recipeItems: state is UserAuthenticated
            ? _mapRecipesToRecipeItems(context, recipes, state.user.id)
            : [],
      ),
    );
  }

  _mapRecipesToRecipeItems(context, List<Recipe> recipes, userId) {
    return recipes
        .map((recipe) => RecipeListItem(
              id: recipe.id,
              name: recipe.name,
              imageUrl: recipe.imageUrl,
              readyInMinutes: recipe.readyInMinutes,
              servings: recipe.servings,
              rating: recipe.rating,
              onTap: () => _navigateToRecipeScreen(context, recipe.id, userId),
            ))
        .toList();
  }

  _navigateToRecipeScreen(context, recipeId, userId) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context)
        .add(FetchRecipeDetails(recipeId: recipeId, userId: userId));
  }
}
