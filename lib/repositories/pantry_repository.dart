import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class PantryRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  PantryRepository({@required FirebaseFirestore firestore, @required UserRepository userRepository}) {
    this._firestore = firestore;
    this._userRepository = userRepository;
  }

  Future<List<ExtendedIngredient>> fetchPantry() async {
    final pantryDocs = (await _firestore
            .collection('pantry-products')
            .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
            .get())
        .docs;

    final List<Product> products = await Future.wait(
      pantryDocs
          .map(
            (doc) => _getProduct(doc.data()['productId'] as String),
          )
          .toList(),
    );
    final List<ExtendedIngredient> pantryProducts = [];
    for (int i = 0; i < pantryDocs.length; i++) {
      pantryProducts.add(ExtendedIngredient(
        product: products[i],
        // amount: (pantryDocs[i].data()['amount'] as num).toDouble(),
        // unit: pantryDocs[i].data()['unit'] as String,
        //expDate: pantryDocs[i].data()['expDate'] as DATEEEEEE,
      ));
    }

    return pantryProducts;
  }

  Future<Product> _getProduct(String productId) {
    return _firestore.collection('products').doc(productId).get().then(
          (doc) => Product(
            id: doc.id,
            name: doc.data()['name'] as String,
            imageUrl: doc.data()['imageUrl'] as String,
          ),
        );
  }

  Future<void> addProductToPantry(String productId) async {
    await (_firestore.collection('pantry-products').doc().set({
      'productId': productId,
      'userId': _userRepository.getCurrentUser().uid,
    }));
  }

  Future<void> updateProductInPantry(String productId) async {}
}
