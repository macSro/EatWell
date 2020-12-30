import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import '../../../bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import '../../../bloc/my_recipes/saved_recipes/saved_recipes_state.dart';
import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../model/recipe.dart';
import '../../misc/icon_text.dart';
import '../../misc/loading.dart';
import '../all_recipes/recipe_list_item.dart';
import '../recipe/recipe_screen.dart';

class SavedRecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build saveddddd');
    return BlocBuilder<SavedRecipesBloc, SavedRecipesState>(
      /*buildWhen: (previous, current) =>
          (previous is SavedRecipesFetched &&
              current is SavedRecipesFetched &&
              previous.recipes.length != current.recipes.length) ||
          previous is SavedRecipesLoading && current is SavedRecipesFetched,*/
      builder: (context, state) => state is SavedRecipesFetched
          ? ListView(
              children: _mapRecipesToRecipeItems(context, state.recipes),
            )
          : LoadingView(text: 'Loading saved recipes...'),
    );
  }

  _mapRecipesToRecipeItems(context, List<Recipe> recipes) {
    return recipes
        .map((recipe) => RecipeListItem(
              recipe: recipe,
              onTap: () => _navigateToRecipeScreen(context, recipe),
              bottom: _getRemoveFromSavedButton(context, recipe.id),
            ))
        .toList();
  }

  Widget _getRemoveFromSavedButton(context, recipeId) {
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
      onPressed: () => BlocProvider.of<SavedRecipesBloc>(context)
          .add(RemoveRecipeFromSaved(recipeId: recipeId)),
    );
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      SelectRecipe(recipe: recipe),
    );
  }
}
