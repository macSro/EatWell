import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeEvent extends Equatable {}

class FetchAllRecipes extends RecipeEvent {
  @override
  List<Object> get props => null;
}

class FetchRecipeInfo extends RecipeEvent {
  final int recipeId;

  FetchRecipeInfo({@required this.recipeId});

  @override
  List<Object> get props => [recipeId];
}
