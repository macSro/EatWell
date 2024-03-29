import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class PantryRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  PantryRepository({
    @required FirebaseFirestore firestore,
    @required UserRepository userRepository,
  }) {
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
            (doc) => getProduct(doc.data()['productId'] as String),
          )
          .toList(),
    );
    final List<ExtendedIngredient> pantryProducts = [];
    for (int i = 0; i < pantryDocs.length; i++) {
      pantryProducts.add(ExtendedIngredient(
        product: products[i],
        amount: (pantryDocs[i].data()['amount'] as num).toDouble(),
        unit: pantryDocs[i].data()['unit'] as String,
        expDate: (pantryDocs[i].data()['expDate'] as Timestamp)?.toDate(),
      ));
    }

    return pantryProducts;
  }

  Future<Product> getProduct(String productId) {
    return _firestore.collection('products').doc(productId).get().then(
          (doc) => Product(
            id: doc.id,
            name: doc.data()['name'] as String,
            imageUrl: doc.data()['imageUrl'] as String,
          ),
        );
  }

  Future<void> addProductToPantry(String productId, double amount, String unit, DateTime expDate) async {
    return _firestore.collection('pantry-products').doc().set({
      'productId': productId,
      'userId': _userRepository.getCurrentUser().uid,
      'amount': amount,
      'unit': unit,
      'expDate': expDate,
    });
  }

  Future<void> removeProductFromPantry(String productId) async {
    return _firestore
        .collection('pantry-products')
        .where('productId', isEqualTo: productId)
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .limit(1)
        .get()
        .then(
          (snap) => _firestore.collection('pantry-products').doc(snap.docs.first.id).delete(),
        );
  }

  Future<void> updateProductInPantry({
    String productId,
    double amount,
    String unit,
    DateTime expDate,
  }) async {
    return _firestore
        .collection('pantry-products')
        .where('productId', isEqualTo: productId)
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .limit(1)
        .get()
        .then(
          (snap) => _firestore.collection('pantry-products').doc(snap.docs.first.id).update({
            'amount': amount,
            'unit': unit,
            'expDate': expDate != null ? Timestamp.fromDate(expDate) : expDate,
          }),
        );
  }
}
