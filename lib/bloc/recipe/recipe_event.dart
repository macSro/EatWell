import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeEvent extends Equatable {}

class FetchRecipeDetails extends RecipeEvent {
  final int recipeId;

  FetchRecipeDetails({@required this.recipeId});

  @override
  List<Object> get props => [recipeId];
}

class UpdateRecipeRating extends RecipeEvent {
  final int recipeId;
  final int rating;

  UpdateRecipeRating({this.recipeId, this.rating});

  @override
  List<Object> get props => [recipeId, rating];
}
