import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SavedRecipesEvent extends Equatable {}

class FetchSavedRecipes extends SavedRecipesEvent {
  @override
  List<Object> get props => [];
}

class SaveRecipe extends SavedRecipesEvent {
  final String recipeId;

  SaveRecipe({@required this.recipeId});

  @override
  List<Object> get props => [recipeId];
}

class RemoveRecipeFromSaved extends SavedRecipesEvent {
  final List<Recipe> currentRecipes;
  final String recipeId;

  RemoveRecipeFromSaved({this.currentRecipes, @required this.recipeId});

  @override
  List<Object> get props => [currentRecipes, recipeId];
}
