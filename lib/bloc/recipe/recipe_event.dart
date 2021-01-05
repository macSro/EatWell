import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';

@immutable
abstract class RecipeEvent extends Equatable {}

class SelectRecipe extends RecipeEvent {
  final Recipe recipe;

  SelectRecipe({@required this.recipe});

  @override
  List<Object> get props => [recipe];
}

class UpdateRecipeRating extends RecipeEvent {
  final Recipe recipe;
  final bool isSaved;
  final int rating;

  UpdateRecipeRating({@required this.recipe, @required this.isSaved, @required this.rating});

  @override
  List<Object> get props => [recipe, isSaved, rating];
}
