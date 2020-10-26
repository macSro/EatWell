import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class SavedRecipesEvent extends Equatable {}

class FetchSavedRecipes extends SavedRecipesEvent {
  final String userId;

  FetchSavedRecipes({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class SaveRecipe extends SavedRecipesEvent {
  final Recipe recipeId;
  final String userId;

  SaveRecipe({@required this.recipeId, @required this.userId});

  @override
  List<Object> get props => [recipeId, userId];
}

class RemoveRecipeFromSaved extends SavedRecipesEvent {
  final int recipeId;
  final String userId;

  RemoveRecipeFromSaved({@required this.recipeId, @required this.userId});

  @override
  List<Object> get props => [recipeId, userId];
}
