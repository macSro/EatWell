import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_state.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/ingredient.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/model/recipe.dart';

import '../../constants.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(RecipeInitial());

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is FetchRecipeDetails)
      yield* _fetchRecipeDetails(event.recipeId, event.userId);
    else if (event is UpdateRecipeRating)
      yield* _updateRecipeRating(event.recipeId, event.rating);
  }

  Stream<RecipeState> _fetchRecipeDetails(int recipeId, String userId) async* {
    yield RecipeLoading();
    //TODO: FIREBASE final recipe = await fetchRecipeDetails(recipeId);
    //TODO: FIREBASE final (int) userRating = await fetchUserRating(recipeId, userId); if null return 0.0!!!
    final userRating = 4;
    final recipe = await Future.delayed(
      Duration(seconds: 2),
      () {
        final recipe = Recipe(
          id: 658703,
          name: 'Roasted Vegetable Tacos',
          imageUrl: kRecipeImageUrlBasePath + '658703-636x393.jpg',
          readyInMinutes: 30,
          servings: 4,
          rating: Rating(points: 10, votes: 4),
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
        );
        return recipe;
      },
    );
    yield RecipeDetailsFetched(recipe: recipe, userRating: userRating);
  }

  Stream<RecipeState> _updateRecipeRating(int recipeId, int rating) async* {
    //TODO: FIREBASE await updateRecipeUserRating(recipeId, rating) -> if [rating]==0 should delete this user rating
    //TODO: FIREBASE await recalculateRecipeRating()
    //TODO: FIREBASE final recipe = await fetchRecipeDetails(recipeId);

    final randomPoints = Random().nextInt(16) + 10;
    print('random points: $randomPoints');
    final recipe = await Future.delayed(
      Duration(seconds: 2),
      () {
        final recipe = Recipe(
          id: 658703,
          name: 'Roasted Vegetable Tacos',
          imageUrl: kRecipeImageUrlBasePath + '658703-636x393.jpg',
          readyInMinutes: 30,
          servings: 4,
          rating: Rating(points: randomPoints, votes: 5),
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
        );
        return recipe;
      },
    );
    yield RecipeRatingUpdated(recipe: recipe, userRating: rating);
    //TODO: error management
  }
}
