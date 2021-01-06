import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';

import 'extended_ingredient.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<ExtendedIngredient> ingredients;
  final List<DishType> dishTypes;
  final List<Cuisine> cuisines;
  final List<Diet> diets;
  final List<String> instructions;
  final int readyInMinutes;
  final int servings;
  final double rating;
  final int inPantry;

  Recipe({
    this.id,
    this.name,
    this.imageUrl,
    this.ingredients,
    this.dishTypes,
    this.cuisines,
    this.diets,
    this.instructions,
    this.readyInMinutes,
    this.servings,
    this.rating,
    this.inPantry,
  });

  Recipe copyWith({
    String id,
    String name,
    String imageUrl,
    List<ExtendedIngredient> ingredients,
    List<String> dishTypes,
    List<String> cuisines,
    List<String> diets,
    List<String> instructions,
    int readyInMinutes,
    int servings,
    double rating,
    int inPantry
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      dishTypes: dishTypes ?? this.dishTypes,
      cuisines: cuisines ?? this.cuisines,
      diets: diets ?? this.diets,
      instructions: instructions ?? this.instructions,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      servings: servings ?? this.servings,
      rating: rating ?? this.rating,
      inPantry: inPantry ?? this.inPantry,
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
        ingredients,
        dishTypes,
        cuisines,
        diets,
        instructions,
        readyInMinutes,
        servings,
        rating,
        inPantry,
      ];

  @override
  bool get stringify => true;
}
