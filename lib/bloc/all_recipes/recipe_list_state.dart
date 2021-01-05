import 'package:flutter/foundation.dart';

import '../../model/recipe.dart';

@immutable
abstract class RecipeListState {}

class RecipeListInitial extends RecipeListState {
}

class RecipeListLoading extends RecipeListState {
}

class RecipesFetched extends RecipeListState {
  final List<Recipe> recipes;

  RecipesFetched({@required this.recipes});
}
