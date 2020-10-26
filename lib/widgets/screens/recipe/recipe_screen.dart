import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_state.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/widgets/misc/authenticated_view.dart';
import 'package:eat_well_v1/widgets/misc/icon_button_stateful.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/recipe/recipe_rating.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'recipe_rating_buttons.dart';

class RecipeScreen extends StatelessWidget {
  static const routeName = '/recipe';

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) => userState is UserAuthenticated
          ? BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, recipeState) {
                return MyScaffold(
                  hasAppBar: false,
                  title: '',
                  hasDrawer: false,
                  child: recipeState is RecipeDetailsFetched
                      ? _getContent(
                          context,
                          mediaQuery,
                          recipeState.recipe,
                          recipeState.userRating,
                          userState.user.id,
                        )
                      : recipeState is RecipeRatingUpdated
                          ? _getContent(
                              context,
                              mediaQuery,
                              recipeState.recipe,
                              recipeState.userRating,
                              userState.user.id,
                            )
                          : LoadingView(text: 'Loading recipe details...'),
                );
              },
            )
          : AuthenticatedView(),
    );
  }

  Widget _getContent(context, mediaQuery, recipe, userRating, userId) {
    return Stack(
      children: [
        ListView(
          children: [
            Column(
              children: [
                _getImage(recipe.imageUrl, mediaQuery.size.width),
                const SizedBox(height: 16),
                RecipeRating(rating: recipe.rating),
                const SizedBox(height: 8),
                Text(
                  recipe.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                _getDetails(context, recipe.readyInMinutes, recipe.servings),
                const SizedBox(height: 32),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: _getIngredientList(recipe.ingredients),
                ),
                const SizedBox(height: 32),
                Text(
                  'Instructions',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _getInstructions(context, recipe.instructions),
                ),
                const SizedBox(height: 32),
                Text(
                  'How did you like this recipe?',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                RecipeRatingButtons(
                    recipeId: recipe.id, userRating: userRating),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(16),
          child: _getBackButton(context),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(16),
          child: _getSaveButton(context, recipe.id, userId),
        ),
      ],
    );
  }

  Widget _getBackButton(context) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.65),
              shape: BoxShape.circle,
            ),
            height: 48,
            width: 48,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _getSaveButton(context, recipeId, userId) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.65),
              shape: BoxShape.circle,
            ),
            height: 48,
            width: 48,
          ),
          ChangingIconButton(
            iconPrimary: Icon(
              Icons.favorite_border_rounded,
              color: Colors.white,
              size: 28,
            ),
            iconSecondary: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: (bool isPrimary) {
              if (isPrimary) {
                BlocProvider.of<SavedRecipesBloc>(context)
                    .add(SaveRecipe(recipeId: recipeId, userId: userId));
              } else {
                BlocProvider.of<SavedRecipesBloc>(context).add(
                    RemoveRecipeFromSaved(recipeId: recipeId, userId: userId));
              }
            },
            //onPressed: _handleRecipeSaving,
          ),
        ],
      ),
    );
  }

  Widget _getImage(url, width) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: url,
        fadeInDuration: const Duration(milliseconds: 400),
        width: width,
      ),
    );
  }

  Widget _getDetails(context, readyInMinutes, servings) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.timer_rounded,
              color: kPrimaryColorDark,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              '$readyInMinutes min',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$servings pers',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.group_rounded,
              color: kPrimaryColorDark,
              size: 28,
            ),
          ],
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _getIngredientList(List<ExtendedIngredient> ingredients) {
    return Container(
      child: Column(
        children: ingredients
            .map(
              (ingredient) => Column(
                children: [
                  IngredientListTile(
                    imageUrl: ingredient.ingredient.imageUrl,
                    name: ingredient.ingredient.name,
                    amount: ingredient.amount,
                    unit: ingredient.unit,
                  ),
                  ingredient != ingredients.last
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Divider(),
                        )
                      : const SizedBox(),
                ],
              ),
            )
            .toList(),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }

  Widget _getInstructions(context, List<String> instructions) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: instructions.asMap().entries.map((entry) {
          int stepNumber = entry.key + 1;
          String instruction = entry.value;

          return Column(
            children: [
              Text(
                'Step #$stepNumber',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                instruction,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.justify,
              ),
              stepNumber != instructions.length
                  ? const Divider(height: 32)
                  : const SizedBox(),
            ],
          );
        }).toList(),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}
