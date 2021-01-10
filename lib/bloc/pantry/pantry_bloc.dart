import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/repositories/pantry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/extended_ingredient.dart';

part 'pantry_event.dart';
part 'pantry_state.dart';

class PantryBloc extends Bloc<PantryEvent, PantryState> {
  PantryRepository _pantryRepository;

  PantryBloc({@required PantryRepository pantryRepository})
      : super(PantryInitial()) {
    _pantryRepository = pantryRepository;
  }

  @override
  Stream<PantryState> mapEventToState(PantryEvent event) async* {
    if (event is FetchPantry)
      yield* _fetchPantry();
    else if (event is AddProductToPantry)
      yield* _addProductToPantry(
        event.currentProducts,
        event.productId,
        event.amount,
        event.unit,
        event.expDate,
      );
    else if (event is RemoveProductFromPantry)
      yield* _removeProductFromPantry(event.currentProducts, event.productId);
    else if (event is UpdateProductInPantry)
      yield* _updateProductInPantry(
        event.currentProducts,
        event.productId,
        event.amount,
        event.unit,
        event.expDate,
      );
  }

  Stream<PantryState> _fetchPantry() async* {
    yield PantryLoading();

    final List<ExtendedIngredient> products =
        await _pantryRepository.fetchPantry();
    yield PantryFetched(products: products);
  }

  Stream<PantryState> _addProductToPantry(
    List<ExtendedIngredient> currentProducts,
    String productId,
    double amount,
    String unit,
    DateTime expDate,
  ) async* {
    yield PantryLoading();

    final ExtendedIngredient newProduct = ExtendedIngredient(
      product: await _pantryRepository
          .addProductToPantry(productId, amount, unit, expDate)
          .then(
            (_) => _pantryRepository.getProduct(productId),
          ),
      amount: amount,
      unit: unit,
      expDate: expDate,
    );

    List<ExtendedIngredient> newProducts = []..addAll(currentProducts);
    newProducts.add(newProduct);

    yield PantryFetched(products: newProducts);
  }

  Stream<PantryState> _removeProductFromPantry(
    List<ExtendedIngredient> currentProducts,
    String productId,
  ) async* {
    yield PantryLoading();

    await _pantryRepository.removeProductFromPantry(productId);

    List<ExtendedIngredient> newProducts = []..addAll(currentProducts);
    newProducts.removeWhere((product) => product.product.id == productId);

    yield PantryFetched(products: newProducts);
  }

  Stream<PantryState> _updateProductInPantry(
    List<ExtendedIngredient> currentProducts,
    String productId,
    double amount,
    String unit,
    DateTime expDate,
  ) async* {
    yield PantryLoading();

    await _pantryRepository.updateProductInPantry(
        productId: productId, amount: amount, unit: unit, expDate: expDate);

    List<ExtendedIngredient> newProducts = []..addAll(currentProducts);

    int index = currentProducts
        .indexWhere((product) => product.product.id == productId);

    ExtendedIngredient updatedProduct = newProducts[index].copyWith(
      amount: amount,
      unit: unit,
      expDate: expDate,
    );

    newProducts[index] = updatedProduct;

    yield PantryFetched(products: newProducts);
  }
}
