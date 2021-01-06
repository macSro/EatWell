import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';
import '../../widgets/screens/filters/recipe_list_filters.dart';

@immutable
abstract class RecipeListEvent extends Equatable {}

class FetchRecipes extends RecipeListEvent {
  @override
  List<Object> get props => [];
}

class FilterAndSortRecipes extends RecipeListEvent {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final RecipeListFilters filters;

  FilterAndSortRecipes({
    @required this.allRecipes,
    @required this.filteredRecipes,
    @required this.filters,
  });

  @override
  List<Object> get props => [allRecipes, filteredRecipes, filters];
}
