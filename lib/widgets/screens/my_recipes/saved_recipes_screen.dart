import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_state.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipe_list.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipe_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedRecipesScreen extends StatelessWidget {
  final String userId;

  SavedRecipesScreen({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedRecipesBloc, SavedRecipesState>(
      builder: (context, state) => state is SavedRecipesFetched
          ? RecipeList(
              recipeItems:
                  _mapRecipesToRecipeItems(context, state.recipes, userId),
            )
          : LoadingView(text: 'Loading saved recipes...'),
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
              bottom: _getRemoveFromSavedButton(),
            ))
        .toList();
  }

  Widget _getRemoveFromSavedButton() {
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
      onPressed: () {},
    );
  }

  _navigateToRecipeScreen(context, recipeId, userId) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context)
        .add(FetchRecipeDetails(recipeId: recipeId, userId: userId));
  }
}
