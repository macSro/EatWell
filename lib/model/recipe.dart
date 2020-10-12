import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<ExtendedIngredient> ingredients;
  final List<String> types;
  final List<String> cuisines;
  final List<String> diets;
  final List<String> instructions;
  final int readyInMinutes;
  final int servings;
  final Rating rating;

  Recipe({
    this.id,
    this.name,
    this.imageUrl,
    this.ingredients,
    this.types,
    this.cuisines,
    this.diets,
    this.instructions,
    this.readyInMinutes,
    this.servings,
    this.rating,
  });

  @override
  List<Object> get props => [id];
}
