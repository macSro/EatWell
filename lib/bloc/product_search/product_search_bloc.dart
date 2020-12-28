import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/product_search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchRepository _productSearchRepository;

  ProductSearchBloc({@required ProductSearchRepository productSearchRepository})
      : super(ProductSearchInitial()) {
    _productSearchRepository = productSearchRepository;
  }

  @override
  Stream<ProductSearchState> mapEventToState(ProductSearchEvent event) async* {
    if (event is FetchProducts)
      yield* _fetchProducts(event.excludedIds);
    else if (event is SearchForProduct) yield* _searchForProduct(event.allProducts, event.searchPhrase);
  }

  Stream<ProductSearchState> _fetchProducts(List<String> excludedIds) async* {
    yield ProductSearchLoading();

    final List<Product> products = await _productSearchRepository.fetchProducts(excludedIds);
    yield ProductsFound(allProducts: products, foundProducts: products);
  }

  Stream<ProductSearchState> _searchForProduct(List<Product> allProducts, String searchPhrase) async* {
    yield ProductSearchLoading();

    if (searchPhrase.isEmpty)
      yield ProductsFound(allProducts: allProducts, foundProducts: allProducts);
    else {
      List<Product> foundProducts = [];
      allProducts.forEach((product) {
        if (product.name.contains(searchPhrase.toLowerCase())) foundProducts.add(product);
      });
      yield ProductsFound(allProducts: allProducts, foundProducts: foundProducts);
    }
  }
}
