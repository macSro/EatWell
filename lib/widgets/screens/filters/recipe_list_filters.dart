import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RecipeListFilters extends Equatable {
  final SortBy sortBy;
  final Map<DishType, bool> dishTypes;
  final Map<Cuisine, bool> cuisines;
  final Map<Diet, bool> diets;

  RecipeListFilters({@required this.sortBy, @required this.dishTypes, @required this.cuisines, @required this.diets});

  @override
  List<Object> get props => [sortBy, dishTypes, cuisines, diets];
}
