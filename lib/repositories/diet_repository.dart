import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class DietRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  DietRepository({
    @required FirebaseFirestore firestore,
    @required UserRepository userRepository,
  }) {
    this._firestore = firestore;
    this._userRepository = userRepository;
  }

  Future<List<Product>> fetchBannedProducts() async {
    final bannedDocs = (await _firestore
            .collection('banned-products')
            .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
            .get())
        .docs;

    return Future.wait(
      bannedDocs
          .map(
            (doc) => getProduct(doc.data()['productId'] as String),
          )
          .toList(),
    );
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

  Future<void> addProductToBanned(String productId) async {
    return _firestore.collection('banned-products').doc().set({
      'productId': productId,
      'userId': _userRepository.getCurrentUser().uid,
    });
  }

  Future<void> removeProductFromBanned(String productId) async {
    return _firestore
        .collection('banned-products')
        .where('productId', isEqualTo: productId)
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .limit(1)
        .get()
        .then((snap) => _firestore
            .collection('banned-products')
            .doc(snap.docs.first.id)
            .delete(),
        );
  }
}
