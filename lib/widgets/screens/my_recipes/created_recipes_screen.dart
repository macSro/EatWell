import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import '../../../bloc/my_recipes/created_recipes/created_recipes_state.dart';
import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../constants.dart';
import '../../../model/recipe.dart';
import '../../misc/icon_text.dart';
import '../../misc/loading.dart';
import '../recipe/recipe_screen.dart';
import '../recipes/recipe_list.dart';
import '../recipes/recipe_list_item.dart';
import 'create_recipe_screen.dart';

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
              recipe: recipe,
              onTap: () => _navigateToRecipeScreen(context, recipe),
            ))
        .toList();
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.pushNamed(context, RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      FetchRecipeDetails(recipe: recipe),
    );
  }
}
