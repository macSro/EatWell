import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../model/recipe.dart';

@immutable
abstract class CreateRecipeEvent extends Equatable {}

class SearchForIngredients extends CreateRecipeEvent {
  final String searchPhrase;

  SearchForIngredients({this.searchPhrase});

  @override
  List<Object> get props => [searchPhrase];
}

class PublishRecipe extends CreateRecipeEvent {
  final Recipe recipe;

  PublishRecipe({this.recipe});

  @override
  List<Object> get props => [recipe];
}
