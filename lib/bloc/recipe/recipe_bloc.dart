import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';
import '../../repositories/recipe_repository.dart';
import '../../repositories/user_repository.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeRepository _recipeRepository;
  UserRepository _userRepository;

  RecipeBloc({
    @required recipeRepository,
    @required userRepository,
  }) : super(RecipeInitial()) {
    _recipeRepository = recipeRepository;
    _userRepository = userRepository;
  }

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is SelectRecipe)
      yield* _selectRecipe(event.recipe);
    else if (event is UpdateRecipeRating) yield* _updateRecipeRating(event.recipe, event.rating);
  }

  Stream<RecipeState> _selectRecipe(Recipe recipe) async* {
    yield RecipeLoading();

    final userRating = await _recipeRepository.fetchUserRating(recipe.id);

    yield RecipeDetailsFetched(recipe: recipe, userRating: userRating);
  }

  Stream<RecipeState> _updateRecipeRating(Recipe recipe, int rating) async* {
    if (rating == 0)
      await _recipeRepository.deleteUserRating(recipe.id);
    else
      await _recipeRepository.updateUserRating(recipe.id, rating);

    final double ratingResult = await _recipeRepository.fetchRecipeRating(recipe.id);

    final Recipe recipeResult = recipe.copyWith(rating: ratingResult);

    // final randomPoints = Random().nextInt(16) + 10;
    // final recipe = await Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     final recipe = Recipe(
    //       id: '658703',
    //       name: 'Roasted Vegetable Tacos',
    //       imageUrl: kRecipeImageUrlBasePath + '658703-636x393.jpg',
    //       readyInMinutes: 30,
    //       servings: 4,
    //       rating: Rating(points: randomPoints, votes: 5),
    //       instructions: [
    //         'Preheat the oven to 375 degrees. In a casserole dish, add the chopped sweet potato, pasilla pepper, bell pepper and onion. In a small bowl, combine the chicken stock, oil and vinegar.',
    //         'Mix to combine and pour evenly over the vegetables.',
    //         'Sprinkle the chili powder, cumin, paprika, and salt over the veggies and stir.',
    //         'Bake in for 30 minutes.',
    //         'Remove the casserole dish from the oven, stir everything well, increase oven heat to 400 and bake 7 to 10 more minutes.',
    //         'Remove from oven and allow to cool slightly.While the vegetables are roasting in the oven, you can cook the corn by boiling it in hot water for 5 to 7 minutes or grilling it.  Carefully remove the kernels with a sharp knife.',
    //         'Heat the black beans in a sauce pan. Chop the goat cheese.',
    //         'Heat your favorite tortillas, place desired amount of ingredients in the tortillas and add extra goodies such as guacamole, salsa and green onion if desire.',
    //       ],
    //       ingredients: [
    //         ExtendedIngredient(
    //           product: Product(
    //             id: '1',
    //             name: 'apple',
    //             imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
    //           ),
    //           amount: 2.0,
    //           unit: 'cups',
    //         ),
    //         ExtendedIngredient(
    //           product: Product(
    //             id: '2',
    //             name: 'broccoli',
    //             imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
    //           ),
    //           amount: 200.0,
    //           unit: 'ml',
    //         ),
    //         ExtendedIngredient(
    //           product: Product(
    //             id: '3',
    //             name: 'garlic',
    //             imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
    //           ),
    //           amount: 1.0,
    //           unit: 'tbsp',
    //         ),
    //         ExtendedIngredient(
    //           product: Product(
    //             id: '4',
    //             name: 'milk',
    //             imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
    //           ),
    //           amount: 1.0,
    //           unit: 'tsp',
    //         ),
    //       ],
    //     );
    //     return recipe;
    //   },
    // );
    // yield RecipeDetailsFetched(recipe: recipe, userRating: rating);
    // //TODO: error management
  }
}
