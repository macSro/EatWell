import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/repositories/saved_recipes_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../model/recipe.dart';
import 'saved_recipes_event.dart';
import 'saved_recipes_state.dart';

class SavedRecipesBloc extends Bloc<SavedRecipesEvent, SavedRecipesState> {
  SavedRecipesRepository _savedRecipesRepository;

  SavedRecipesBloc({@required SavedRecipesRepository savedRecipesRepository}) : super(SavedRecipesInitial()) {
    this._savedRecipesRepository = savedRecipesRepository;
  }

  @override
  Stream<SavedRecipesState> mapEventToState(SavedRecipesEvent event) async* {
    if (event is FetchSavedRecipes)
      yield* _fetchSavedRecipes();
    else if (event is SaveRecipe)
      yield* _saveRecipe(event.recipeId);
    else if (event is RemoveRecipeFromSaved)
      yield* _removeRecipeFromSaved(event.currentRecipes, event.recipeId);
  }

  Stream<SavedRecipesState> _fetchSavedRecipes() async* {
    yield SavedRecipesLoading();

    final List<Recipe> recipes = await _savedRecipesRepository.fetchSavedRecipes();

    yield SavedRecipesFetched(recipes: recipes);
  }

  Stream<SavedRecipesState> _saveRecipe(recipeId) async* {
    await _savedRecipesRepository.saveRecipe(recipeId);
  }

  Stream<SavedRecipesState> _removeRecipeFromSaved(List<Recipe> currentRecipes, String recipeId) async* {
    if (currentRecipes != null) {
      yield SavedRecipesLoading();

      await _savedRecipesRepository.removeRecipeFromSaved(recipeId);

      List<Recipe> newRecipes = currentRecipes;
      newRecipes.removeWhere((recipe) => recipe.id == recipeId);

      yield SavedRecipesFetched(recipes: newRecipes);
    }
    else{
      await _savedRecipesRepository.removeRecipeFromSaved(recipeId);
    }
  }
}
