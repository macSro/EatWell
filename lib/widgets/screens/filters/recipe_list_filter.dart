import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';

class RecipeListFilters extends Equatable {
  final List<MealType> dishTypes;
  final List<Cuisine> cuisines;
  final List<Diet> diets;

  RecipeListFilters({this.dishTypes, this.cuisines, this.diets});

  @override
  List<Object> get props => [dishTypes, cuisines, diets];
}
