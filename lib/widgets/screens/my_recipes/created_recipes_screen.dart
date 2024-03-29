import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import '../../../bloc/my_recipes/created_recipes/created_recipes_state.dart';
import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../constants.dart';
import '../../misc/icon_text.dart';
import '../../misc/loading.dart';
import '../all_recipes/recipe_list_item.dart';
import '../recipe/recipe_screen.dart';
import 'create_recipe/create_recipe_screen.dart';

class CreatedRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatedRecipesBloc, CreatedRecipesState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is CreatedRecipesFetched) _getCreateRecipeButton(context),
            Expanded(
              child: _getRecipeList(context, state),
            ),
          ],
        );
      },
    );
  }

  Widget _getCreateRecipeButton(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RaisedButton(
        onPressed: () => _navigateToCreateRecipeScreen(context),
        padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _getRecipeList(context, CreatedRecipesState state) {
    return state is CreatedRecipesFetched
        ? state.recipes.isNotEmpty
            ? ListView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (context, index) => RecipeListItem(
                  recipe: state.recipes[index],
                  onTap: () => _navigateToRecipeScreen(context, state.recipes[index]),
                  bottom: _getEditAndDeleteButtons(context, state.recipes, state.recipes[index].id),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_food_rounded,
                    color: kPrimaryColor,
                    size: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'You haven\'t created any recipes yet!',
                      style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
        : LoadingView(text: 'Loading created recipes...');
  }

  Widget _getEditAndDeleteButtons(context, currentRecipes, recipeId) {
    return RaisedButton(
      color: Colors.redAccent,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconText(
            icon: Icon(Icons.delete_rounded),
            text: Text(
              'Delete',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      onPressed: () => BlocProvider.of<CreatedRecipesBloc>(context).add(
        DeleteRecipe(currentRecipes: currentRecipes, recipeId: recipeId),
      ),
    );
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.pushNamed(context, RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      SelectRecipe(recipe: recipe),
    );
  }
}
