import 'package:eat_well_v1/model/recipe.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeListState extends Equatable {}

class RecipeListInitial extends RecipeListState {
  @override
  List<Object> get props => [];
}

class RecipeListLoading extends RecipeListState {
  @override
  List<Object> get props => [];
}

class RecipesFetched extends RecipeListState {
  final List<Recipe> recipes;

  RecipesFetched({this.recipes});

  @override
  List<Object> get props => [recipes];
}
