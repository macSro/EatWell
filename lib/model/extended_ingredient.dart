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

  ExtendedIngredient copyWith({
    Product product,
    double amount,
    String unit,
    DateTime expDate,
  }){
    return ExtendedIngredient(
      product: product ?? this.product,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      expDate: expDate ?? this.expDate,
    );
  }

  @override
  List<Object> get props => [product, amount, unit, expDate];

  @override
  bool get stringify => true;
}
