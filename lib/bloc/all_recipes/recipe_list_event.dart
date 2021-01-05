import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';
import '../../widgets/screens/filters/recipe_list_filter.dart';

@immutable
abstract class RecipeListEvent extends Equatable {}

class FetchRecipes extends RecipeListEvent {
  @override
  List<Object> get props => [];
}

class SortRecipes extends RecipeListEvent {
  final List<Recipe> recipes;
  final SortBy sortBy;

  SortRecipes({@required this.recipes, @required this.sortBy});

  @override
  List<Object> get props => [recipes, sortBy];
}

class FilterRecipes extends RecipeListEvent {
  final List<Recipe> recipes;
  final RecipeListFilters filters;

  FilterRecipes({@required this.recipes, @required this.filters});

  @override
  List<Object> get props => [recipes, filters];
}
