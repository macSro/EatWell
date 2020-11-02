import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CreatedRecipesState extends Equatable {}

class CreatedRecipesInitial extends CreatedRecipesState {
  @override
  List<Object> get props => [];
}

class CreatedRecipesLoading extends CreatedRecipesState {
  @override
  List<Object> get props => [];
}

class CreatedRecipesFetched extends CreatedRecipesState {
  final List<Recipe> recipes;

  CreatedRecipesFetched({this.recipes});

  @override
  List<Object> get props => [recipes];
}

class RecipeCreated extends CreatedRecipesState {
  @override
  List<Object> get props => [];
}

class RecipeModified extends CreatedRecipesState {
  @override
  List<Object> get props => [];
}

class RecipeDeleted extends CreatedRecipesState {
  @override
  List<Object> get props => [];
}
