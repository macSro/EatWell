import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';
import '../../widgets/screens/filters/recipe_list_filter.dart';

@immutable
abstract class RecipeListEvent extends Equatable {}

class FetchAllRecipes extends RecipeListEvent {
  @override
  List<Object> get props => [];
}

class FetchFilteredRecipes extends RecipeListEvent {
  final RecipeListFilters filters;

  FetchFilteredRecipes({@required this.filters});

  @override
  List<Object> get props => [filters];
}

class UpdateRecipes extends RecipeListEvent {
  final List<Recipe> recipes;

  UpdateRecipes({this.recipes});

  @override
  List<Object> get props => [];
}
