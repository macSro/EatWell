import 'dart:io';

import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../constants.dart';
import '../../../model/recipe.dart';

@immutable
abstract class CreatedRecipesEvent extends Equatable {}

class FetchCreatedRecipes extends CreatedRecipesEvent {
  @override
  List<Object> get props => [];
}

class CreateRecipe extends CreatedRecipesEvent {
  final List<Recipe> currentRecipes;
  final String name;
  final File imageFile;
  final List<ExtendedIngredient> ingredients;
  final List<DishType> dishTypes;
  final List<Cuisine> cuisines;
  final List<Diet> diets;
  final List<String> instructions;
  final int readyInMinutes;
  final int servings;

  CreateRecipe({
    @required this.currentRecipes,
    @required this.name,
    @required this.imageFile,
    @required this.ingredients,
    @required this.dishTypes,
    @required this.cuisines,
    @required this.diets,
    @required this.instructions,
    @required this.readyInMinutes,
    @required this.servings,
  });

  @override
  List<Object> get props => [
        currentRecipes,
        name,
        imageFile,
        ingredients,
        dishTypes,
        cuisines,
        diets,
        instructions,
        readyInMinutes,
        servings,
      ];
}

class DeleteRecipe extends CreatedRecipesEvent {
  final List<Recipe> currentRecipes;
  final String recipeId;

  DeleteRecipe({@required this.currentRecipes, @required this.recipeId});

  @override
  List<Object> get props => [currentRecipes, recipeId];
}
