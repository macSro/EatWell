part of 'pantry_bloc.dart';

abstract class PantryEvent extends Equatable {
  const PantryEvent();

  @override
  List<Object> get props => [];
}

class FetchPantry extends PantryEvent {
  @override
  List<Object> get props => [];
}

class AddProductToPantry extends PantryEvent {
  final List<ExtendedIngredient> currentProducts;
  final String productId;
  final double amount;
  final String unit;
  final DateTime expDate;

  AddProductToPantry({
    @required this.currentProducts,
    @required this.productId,
    @required this.amount,
    @required this.unit,
    this.expDate,
  });

  @override
  List<Object> get props => [
        currentProducts,
        productId,
        amount,
        unit,
        expDate,
      ];
}

class RemoveProductFromPantry extends PantryEvent {
  final List<ExtendedIngredient> currentProducts;
  final String productId;

  RemoveProductFromPantry(
      {@required this.currentProducts, @required this.productId});

  @override
  List<Object> get props => [currentProducts, productId];
}

class UpdateProductInPantry extends PantryEvent {
  final List<ExtendedIngredient> currentProducts;
  final String productId;
  final double amount;
  final String unit;
  final DateTime expDate;

  UpdateProductInPantry({
    @required this.currentProducts,
    @required this.productId,
    this.amount,
    this.unit,
    this.expDate,
  });

  @override
  List<Object> get props => [currentProducts, productId, amount, unit, expDate];
}
