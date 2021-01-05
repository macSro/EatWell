import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';
import '../../repositories/recipe_repository.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeRepository _recipeRepository;

  RecipeBloc({@required recipeRepository}) : super(RecipeInitial()) {
    _recipeRepository = recipeRepository;
  }

  @override
  Stream<RecipeState> mapEventToState(RecipeEvent event) async* {
    if (event is SelectRecipe)
      yield* _selectRecipe(event.recipe);
    else if (event is UpdateRecipeRating)
      yield* _updateRecipeRating(event.recipe, event.isSaved, event.rating);
  }

  Stream<RecipeState> _selectRecipe(Recipe recipe) async* {
    yield RecipeLoading();

    final int userRating = await _recipeRepository.fetchUserRating(recipe.id);

    final bool isSaved = await _recipeRepository.isRecipeSaved(recipe.id);

    yield RecipeDetailsFetched(recipe: recipe, isSaved: isSaved, userRating: userRating);
  }

  Stream<RecipeState> _updateRecipeRating(Recipe recipe, bool isSaved, int rating) async* {
    if (rating == 0)
      await _recipeRepository.deleteUserRating(recipe.id);
    else
      await _recipeRepository.updateUserRating(recipe.id, rating);

    final double ratingResult = await _recipeRepository.fetchRecipeRating(recipe.id);

    final Recipe recipeResult = recipe.copyWith(rating: ratingResult);

    yield RecipeDetailsFetched(recipe: recipeResult, isSaved: isSaved, userRating: rating);
  }
}
