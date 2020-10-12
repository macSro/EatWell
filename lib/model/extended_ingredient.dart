import 'package:eat_well_v1/model/ingredient.dart';
import 'package:flutter/cupertino.dart';

class ExtendedIngredient {
  final Ingredient ingredient;
  final double amount;
  final String unit;
  final DateTime expDate;

  ExtendedIngredient(
      {@required this.ingredient, this.amount, this.unit, this.expDate});
}
