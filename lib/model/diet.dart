import 'package:eat_well_v1/model/ingredient.dart';
import 'package:equatable/equatable.dart';

import '../constants.dart';

class Diet extends Equatable {
  final Map<Diets, bool> diets;
  final List<Ingredient> bannedProducts;

  Diet({this.diets, this.bannedProducts});

  @override
  List<Object> get props => [diets, bannedProducts];
}
