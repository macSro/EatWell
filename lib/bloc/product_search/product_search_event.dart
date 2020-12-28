part of 'product_search_bloc.dart';

abstract class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductSearchEvent {
  final List<String> excludedIds;

  FetchProducts({this.excludedIds});

  @override
  List<Object> get props => [excludedIds];
}

class SearchForProduct extends ProductSearchEvent {
  final List<Product> allProducts;
  final String searchPhrase;

  SearchForProduct({@required this.allProducts, @required this.searchPhrase});

  @override
  List<Object> get props => [allProducts, searchPhrase];
}
