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
  }
}
