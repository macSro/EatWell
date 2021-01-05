import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';

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
  final bool isSaved;

  RecipeDetailsFetched({this.recipe, this.userRating, this.isSaved});

  @override
  List<Object> get props => [recipe, userRating, isSaved];
}
