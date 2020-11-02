import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CreateRecipeEvent extends Equatable {}

class SearchForIngredients extends CreateRecipeEvent {
  final String searchPhrase;

  SearchForIngredients({this.searchPhrase});

  @override
  List<Object> get props => [searchPhrase];
}
