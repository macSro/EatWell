import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import '../../../bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import '../../../bloc/my_recipes/saved_recipes/saved_recipes_state.dart';
import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../constants.dart';
import '../../misc/icon_text.dart';
import '../../misc/loading.dart';
import '../all_recipes/recipe_list_item.dart';
import '../recipe/recipe_screen.dart';

class SavedRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedRecipesBloc, SavedRecipesState>(
      builder: (context, state) => state is SavedRecipesFetched
          ? state.recipes.isNotEmpty
              ? ListView.builder(
                  itemCount: state.recipes.length,
                  itemBuilder: (context, index) => RecipeListItem(
                    recipe: state.recipes[index],
                    onTap: () => _navigateToRecipeScreen(context, state.recipes[index]),
                    bottom: _getRemoveFromSavedButton(context, state.recipes, state.recipes[index].id),
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
                        'You haven\'t saved any recipes yet!',
                        style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
          : LoadingView(text: 'Loading saved recipes...'),
    );
  }

  Widget _getRemoveFromSavedButton(context, currentRecipes, recipeId) {
    return RaisedButton(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconText(
            icon: Icon(Icons.delete_rounded),
            text: Text('Remove from Saved'),
          ),
        ],
      ),
      onPressed: () => BlocProvider.of<SavedRecipesBloc>(context).add(
        RemoveRecipeFromSaved(currentRecipes: currentRecipes, recipeId: recipeId),
      ),
    );
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      SelectRecipe(recipe: recipe),
    );
  }
}
