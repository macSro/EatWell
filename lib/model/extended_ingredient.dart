import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'product.dart';

class ExtendedIngredient extends Equatable {
  final Product product;
  final double amount;
  final String unit;
  final DateTime expDate;

  ExtendedIngredient({
    @required this.product,
    this.amount,
    this.unit,
    this.expDate,
  });

  @override
  List<Object> get props => [product, amount, unit, expDate];

  @override
  bool get stringify => true;
}
