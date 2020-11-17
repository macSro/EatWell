import 'package:equatable/equatable.dart';

class RecipeListFilters extends Equatable {
  final List<String> dishTypes;
  final List<String> cuisines;
  final List<String> diets;

  RecipeListFilters({this.dishTypes, this.cuisines, this.diets});

  @override
  List<Object> get props => [dishTypes, cuisines, diets];
}
