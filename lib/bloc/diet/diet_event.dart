part of 'diet_bloc.dart';

abstract class DietEvent extends Equatable {
  const DietEvent();

  @override
  List<Object> get props => [];
}

class FetchBannedProducts extends DietEvent {
  @override
  List<Object> get props => [];
}

class AddProductToBanned extends DietEvent {
  final List<Product> currentProducts;
  final String productId;

  AddProductToBanned({@required this.currentProducts, @required this.productId});

  @override
  List<Object> get props => [currentProducts, productId];
}

class RemoveProductFromBanned extends DietEvent {
  final List<Product> currentProducts;
  final String productId;

  RemoveProductFromBanned({@required this.currentProducts, @required this.productId});

  @override
  List<Object> get props => [currentProducts, productId];
}
