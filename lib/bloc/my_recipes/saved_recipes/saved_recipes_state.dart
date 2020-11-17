import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../model/recipe.dart';

@immutable
abstract class SavedRecipesState extends Equatable {}

class SavedRecipesInitial extends SavedRecipesState {
  @override
  List<Object> get props => [];
}

class SavedRecipesLoading extends SavedRecipesState {
  @override
  List<Object> get props => [];
}

class SavedRecipesFetched extends SavedRecipesState {
  final List<Recipe> recipes;

  SavedRecipesFetched({this.recipes});

  @override
  List<Object> get props => [recipes];
}

class RecipeSaved extends SavedRecipesState {
  @override
  List<Object> get props => [];
}

class RecipeRemovedFromSaved extends SavedRecipesState {
  @override
  List<Object> get props => [];
}
