import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeState extends Equatable {}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => null;
}

class RecipeLoading extends RecipeState {
  @override
  List<Object> get props => null;
}

class FetchedAllRecipes extends RecipeState {
  final List<Recipe> recipes;

  FetchedAllRecipes({this.recipes});

  @override
  List<Object> get props => [recipes];
}

class FetchedRecipeInfo extends RecipeState {
  final Recipe recipe;

  FetchedRecipeInfo({this.recipe});

  @override
  List<Object> get props => [recipe];
}
