import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_state.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/screens/my_recipes/create_recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipe_list.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipe_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class CreatedRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getCreateRecipeButton(context),
        Expanded(
          child: _getRecipeList(context),
        ),
      ],
    );
  }

  Widget _getCreateRecipeButton(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RaisedButton(
        onPressed: () => _navigateToCreateRecipeScreen(context),
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: kAccentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 16),
            IconText(
              text: Text(
                'Create a new recipe!',
                style: TextStyle().copyWith(fontSize: 24),
              ),
              icon: Icon(Icons.restaurant_menu_rounded),
              //spacing: 12,
            ),
            Spacer(),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 32,
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  _navigateToCreateRecipeScreen(context) {
    Navigator.pushNamed(context, CreateRecipeScreen.routeName);
  }

  Widget _getRecipeList(context) {
    return BlocBuilder<CreatedRecipesBloc, CreatedRecipesState>(
      builder: (context, state) => state is CreatedRecipesFetched
          ? state.recipes.isNotEmpty
              ? RecipeList(
                  recipeItems: _mapRecipesToRecipeItems(
                    context,
                    state.recipes,
                  ),
                )
              : Center(
                  child: Text(
                    'You haven\'t created any recipes yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
          : LoadingView(text: 'Loading created recipes...'),
    );
  }

  _mapRecipesToRecipeItems(context, List<Recipe> recipes) {
    return recipes
        .map((recipe) => RecipeListItem(
              id: recipe.id,
              name: recipe.name,
              imageUrl: recipe.imageUrl,
              readyInMinutes: recipe.readyInMinutes,
              servings: recipe.servings,
              rating: recipe.rating,
              onTap: () => _navigateToRecipeScreen(context, recipe.id),
            ))
        .toList();
  }

  _navigateToRecipeScreen(context, recipeId) {
    Navigator.pushNamed(context, RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      FetchRecipeDetails(recipeId: recipeId),
    );
  }
}
