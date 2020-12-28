import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/repositories/pantry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/extended_ingredient.dart';
import '../../model/product.dart';

part 'pantry_event.dart';
part 'pantry_state.dart';

class PantryBloc extends Bloc<PantryEvent, PantryState> {
  PantryRepository _pantryRepository;

  PantryBloc({@required PantryRepository pantryRepository}) : super(PantryInitial()) {
    _pantryRepository = pantryRepository;
  }

  @override
  Stream<PantryState> mapEventToState(PantryEvent event) async* {
    if (event is FetchPantry)
      yield* _fetchPantry();
    else if (event is AddProductToPantry)
      yield* _addProductToPantry(event.productId);
    else if (event is UpdateProductInPantry) yield* _updateProductInPantry(event.product);
  }

  Stream<PantryState> _fetchPantry() async* {
    yield PantryLoading();

    final List<ExtendedIngredient> products = await _pantryRepository.fetchPantry();
    yield PantryFetched(products: products);
  }

  Stream<PantryState> _addProductToPantry(String productId) async* {
    yield PantryLoading();

    await _pantryRepository.addProductToPantry(productId);
    add(FetchPantry());
  }

  Stream<PantryState> _updateProductInPantry(Product product) async* {
    //moze byc inaczej, tak czy owak brakuje danych do zmiany: amount itd
  }
}
