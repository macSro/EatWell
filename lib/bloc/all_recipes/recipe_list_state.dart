import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';

@immutable
abstract class RecipeListState {}

class RecipeListInitial extends RecipeListState {}

class RecipeListLoading extends RecipeListState {}

class RecipesFiltered extends RecipeListState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;

  RecipesFiltered({@required this.allRecipes, @required this.filteredRecipes});
}

class RecipesFetched extends RecipeListState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;

  RecipesFetched({@required this.allRecipes, @required this.filteredRecipes});
}
