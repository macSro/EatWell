import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CreatedRecipesEvent extends Equatable {}

class FetchCreatedRecipes extends CreatedRecipesEvent {
  final String userId;

  FetchCreatedRecipes({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateRecipe extends CreatedRecipesEvent {
  final Recipe recipe;
  final String userId;

  CreateRecipe({@required this.recipe, @required this.userId});

  @override
  List<Object> get props => [recipe, userId];
}

class ModifyRecipe extends CreatedRecipesEvent {
  final Recipe recipe;
  final String userId;

  ModifyRecipe({@required this.recipe, @required this.userId});

  @override
  List<Object> get props => [recipe, userId];
}

class DeleteRecipe extends CreatedRecipesEvent {
  final int recipeId;
  final String userId;

  DeleteRecipe({@required this.recipeId, @required this.userId});

  @override
  List<Object> get props => [recipeId, userId];
}
