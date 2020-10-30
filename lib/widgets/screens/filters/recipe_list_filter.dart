import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';

class RecipeListFilters extends Equatable {
  final Map<MealTypes, bool> mealTypes;
  final Map<Cuisines, bool> cuisines;
  final Map<Diets, bool> diets;

  RecipeListFilters({this.mealTypes, this.cuisines, this.diets});

  @override
  List<Object> get props => [mealTypes, cuisines, diets];
}
