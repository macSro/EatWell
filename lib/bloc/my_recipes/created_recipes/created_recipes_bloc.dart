import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/repositories/created_recipes_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../constants.dart';
import '../../../model/recipe.dart';
import 'created_recipes_event.dart';
import 'created_recipes_state.dart';

class CreatedRecipesBloc extends Bloc<CreatedRecipesEvent, CreatedRecipesState> {
  CreatedRecipesRepository _createdRecipesRepository;

  CreatedRecipesBloc({@required CreatedRecipesRepository createdRecipesRepository})
      : super(CreatedRecipesInitial()) {
    this._createdRecipesRepository = createdRecipesRepository;
  }

  @override
  Stream<CreatedRecipesState> mapEventToState(event) async* {
    if (event is FetchCreatedRecipes)
      yield* _fetchCreatedRecipes();
    else if (event is CreateRecipe)
      yield* _createRecipe(
        currentRecipes: event.currentRecipes,
        name: event.name,
        imageFile: event.imageFile,
        ingredients: event.ingredients,
        dishTypes: event.dishTypes,
        cuisines: event.cuisines,
        diets: event.diets,
        instructions: event.instructions,
        readyInMinutes: event.readyInMinutes,
        servings: event.servings,
      );
    else if (event is DeleteRecipe) yield* _deleteRecipe(event.currentRecipes, event.recipeId);
  }

  Stream<CreatedRecipesState> _fetchCreatedRecipes() async* {
    yield CreatedRecipesLoading();

    final List<Recipe> recipes = await _createdRecipesRepository.fetchCreatedRecipes();

    yield CreatedRecipesFetched(recipes: recipes);
  }

  Stream<CreatedRecipesState> _createRecipe({
    @required List<Recipe> currentRecipes,
    @required String name,
    @required File imageFile,
    @required List<ExtendedIngredient> ingredients,
    @required List<DishType> dishTypes,
    @required List<Cuisine> cuisines,
    @required List<Diet> diets,
    @required List<String> instructions,
    @required int readyInMinutes,
    @required int servings,
  }) async* {
    yield CreatedRecipesLoading();

    final Recipe recipe = await _createdRecipesRepository.createRecipe(
      name: name,
      imageFile: imageFile,
      ingredients: ingredients,
      dishTypes: dishTypes,
      cuisines: cuisines,
      diets: diets,
      instructions: instructions,
      readyInMinutes: readyInMinutes,
      servings: servings,
    );

    final List<Recipe> newRecipes = []..addAll(currentRecipes);
    if (recipe != null) newRecipes.add(recipe);

    yield CreatedRecipesFetched(recipes: newRecipes);
  }

  Stream<CreatedRecipesState> _deleteRecipe(List<Recipe> currentRecipes, String recipeId) async* {
    yield CreatedRecipesLoading();

    await _createdRecipesRepository.deleteRecipe(recipeId);

    List<Recipe> newRecipes = []..addAll(currentRecipes);
    newRecipes.removeWhere((recipe) => recipe.id == recipeId);

    yield CreatedRecipesFetched(recipes: newRecipes);
  }
}
