import 'package:equatable/equatable.dart';

import 'extended_ingredient.dart';
import 'rating.dart';

class Recipe extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final List<ExtendedIngredient> ingredients;
  final List<String> dishTypes;
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
    this.dishTypes,
    this.cuisines,
    this.diets,
    this.instructions,
    this.readyInMinutes,
    this.servings,
    this.rating,
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
    Rating rating,
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
      ];

  @override
  bool get stringify => true;
}
