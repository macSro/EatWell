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
  final String productId;

  AddProductToPantry({this.productId});

  @override
  List<Object> get props => [productId];
}

class UpdateProductInPantry extends PantryEvent {
  final Product product;

  UpdateProductInPantry({this.product});

  @override
  List<Object> get props => [product];
}
