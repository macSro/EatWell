import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../model/recipe.dart';

@immutable
abstract class CreatedRecipesEvent extends Equatable {}

class FetchCreatedRecipes extends CreatedRecipesEvent {
  @override
  List<Object> get props => [];
}

class CreateRecipe extends CreatedRecipesEvent {
  final Recipe recipe;

  CreateRecipe({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class ModifyRecipe extends CreatedRecipesEvent {
  final Recipe recipe;

  ModifyRecipe({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class DeleteRecipe extends CreatedRecipesEvent {
  final int recipeId;

  DeleteRecipe({@required this.recipeId});

  @override
  List<Object> get props => [recipeId];
}
