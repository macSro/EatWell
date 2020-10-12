import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/ingredient.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/misc/loading_screen.dart';
import 'package:eat_well_v1/widgets/misc/recipe/recipe_rating.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:eat_well_v1/widgets/recipe/recipe_rating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeScreen extends StatelessWidget {
  static const routeName = '/recipe';

  final Recipe recipe;

  RecipeScreen({this.recipe});

  @override
  Widget build(BuildContext context) {
    var recipe = Recipe(
      name: 'Roasted Vegetable Tacos',
      imageUrl: kRecipeImageUrlBasePath + '658703-636x393.jpg',
      readyInMinutes: 30,
      servings: 4,
      instructions: [
        'Preheat the oven to 375 degrees. In a casserole dish, add the chopped sweet potato, pasilla pepper, bell pepper and onion. In a small bowl, combine the chicken stock, oil and vinegar.',
        'Mix to combine and pour evenly over the vegetables.',
        'Sprinkle the chili powder, cumin, paprika, and salt over the veggies and stir.',
        'Bake in for 30 minutes.',
        'Remove the casserole dish from the oven, stir everything well, increase oven heat to 400 and bake 7 to 10 more minutes.',
        'Remove from oven and allow to cool slightly.While the vegetables are roasting in the oven, you can cook the corn by boiling it in hot water for 5 to 7 minutes or grilling it.  Carefully remove the kernels with a sharp knife.',
        'Heat the black beans in a sauce pan. Chop the goat cheese.',
        'Heat your favorite tortillas, place desired amount of ingredients in the tortillas and add extra goodies such as guacamole, salsa and green onion if desire.',
      ],
      ingredients: [
        ExtendedIngredient(
          ingredient: Ingredient(
            id: 1,
            name: 'apple',
            imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
          ),
          amount: 2.0,
          unit: 'cups',
        ),
        ExtendedIngredient(
          ingredient: Ingredient(
            id: 2,
            name: 'broccoli',
            imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
          ),
          amount: 200.0,
          unit: 'ml',
        ),
        ExtendedIngredient(
          ingredient: Ingredient(
            id: 3,
            name: 'garlic',
            imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
          ),
          amount: 1.0,
          unit: 'tbsp',
        ),
        ExtendedIngredient(
          ingredient: Ingredient(
            id: 4,
            name: 'milk',
            imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
          ),
          amount: 1.0,
          unit: 'tsp',
        ),
      ],
      rating: Rating(points: 20, votes: 4),
    );
    var mediaQuery = MediaQuery.of(context);
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoading) {
          return LoadingScreen();
        } else
          return MyScaffold(
            title: recipe.name,
            hasDrawer: false,
            child: ListView(
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
                    _getDetails(
                        context, recipe.readyInMinutes, recipe.servings),
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
                    RecipeRatingButtons(recipe.id),
                    const SizedBox(height: 32),
                  ],
                ),
              ],
            ),
          );
      },
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
      child: Image.network(
        url,
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
                          child: Divider(),
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
                  ? Divider(height: 32)
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
