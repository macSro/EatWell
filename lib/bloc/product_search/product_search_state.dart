part of 'product_search_bloc.dart';

abstract class ProductSearchState extends Equatable {
  const ProductSearchState();

  @override
  List<Object> get props => [];
}

class ProductSearchInitial extends ProductSearchState {
  @override
  List<Object> get props => [];
}

class ProductSearchLoading extends ProductSearchState {
  @override
  List<Object> get props => [];
}

class ProductsFound extends ProductSearchState {
  final List<Product> allProducts;
  final List<Product> foundProducts;

  ProductsFound({@required this.allProducts, @required this.foundProducts});

  @override
  List<Object> get props => [allProducts, foundProducts];
}

class AllProductsFetched extends ProductSearchState {
  final List<Product> products;

  AllProductsFetched({this.products});

  @override
  List<Object> get props => [];
}
