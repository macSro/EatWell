import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/diet_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'diet_event.dart';
part 'diet_state.dart';

class DietBloc extends Bloc<DietEvent, DietState> {
  DietRepository _dietRepository;

  DietBloc({@required DietRepository dietRepository}) : super(DietInitial()) {
    this._dietRepository = dietRepository;
  }

  @override
  Stream<DietState> mapEventToState(DietEvent event) async* {
    if (event is FetchBannedProducts)
      yield* _fetchBannedProducts();
    else if (event is AddProductToBanned)
      yield* _addProductToBanned(event.currentProducts, event.productId);
    else if (event is RemoveProductFromBanned)
      yield* _removeProductFromBanned(event.currentProducts, event.productId);
  }

  Stream<DietState> _fetchBannedProducts() async* {
    yield DietLoading();

    final List<Product> products = await _dietRepository.fetchBannedProducts();

    yield BannedProductsFetched(products: products);
  }

  Stream<DietState> _addProductToBanned(List<Product> currentProducts, String productId) async* {
    yield DietLoading();

    await _dietRepository.addProductToBanned(productId);

    final Product newProduct = await _dietRepository.getProduct(productId);

    List<Product> newProducts = []..addAll(currentProducts);
    newProducts.add(newProduct);

    yield BannedProductsFetched(products: newProducts);
  }

  Stream<DietState> _removeProductFromBanned(List<Product> currentProducts, String productId) async* {
    yield DietLoading();

    await _dietRepository.removeProductFromBanned(productId);

    List<Product> newProducts = []..addAll(currentProducts);
    newProducts.removeWhere((product) => product.id == productId);

    yield BannedProductsFetched(products: newProducts);
  }
}
