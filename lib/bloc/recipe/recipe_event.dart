import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';

@immutable
abstract class RecipeEvent extends Equatable {}

class FetchRecipeDetails extends RecipeEvent {
  final Recipe recipe;

  FetchRecipeDetails({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class UpdateRecipeRating extends RecipeEvent {
  final String recipeId;
  final int rating;

  UpdateRecipeRating({this.recipeId, this.rating});

  @override
  List<Object> get props => [recipeId, rating];
}
