import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class RecipeListEvent extends Equatable {}

class FetchAllRecipes extends RecipeListEvent {
  @override
  List<Object> get props => [];
}
