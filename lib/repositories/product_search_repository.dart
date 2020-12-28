import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:flutter/foundation.dart';

class ProductSearchRepository {
  FirebaseFirestore _firestore;

  ProductSearchRepository({@required FirebaseFirestore firestore}) {
    this._firestore = firestore;
  }

  Future<List<Product>> fetchProducts(List<String> excludedIds) async {
    List<Product> products = (await _firestore.collection('products').orderBy('name').get())
        .docs
        .map(
          (doc) => Product(
            id: doc.id,
            name: doc.data()['name'] as String,
            imageUrl: doc.data()['imageUrl'] as String,
          ),
        )
        .toList();

    products.removeWhere((product) => excludedIds.contains(product.id));

    return products;
  }
}
