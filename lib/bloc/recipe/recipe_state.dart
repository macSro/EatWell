import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeState extends Equatable {}

class RecipeInitial extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeLoading extends RecipeState {
  @override
  List<Object> get props => [];
}

class RecipeDetailsFetched extends RecipeState {
  final Recipe recipe;
  final int userRating;

  RecipeDetailsFetched({this.recipe, this.userRating});

  @override
  List<Object> get props => [recipe, userRating];
}

class RecipeRatingUpdated extends RecipeState {
  final Recipe recipe;
  final int userRating;

  RecipeRatingUpdated({this.recipe, this.userRating});

  @override
  List<Object> get props => [recipe, userRating];
}
