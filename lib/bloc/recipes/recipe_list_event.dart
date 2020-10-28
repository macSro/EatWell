import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
