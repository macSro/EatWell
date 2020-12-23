import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/extended_ingredient.dart';
import '../model/product.dart';
import 'user_repository.dart';

class RecipeRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  RecipeRepository(
      {@required FirebaseFirestore firestore, @required UserRepository userRepository}) {
    this._firestore = firestore;
    this._userRepository = userRepository;
  }

  Future<List<ExtendedIngredient>> fetchRecipeIngredients(String recipeId) async {
    final ingredientDocs = (await _firestore
            .collection('recipe-ingredients')
            .where('recipeId', isEqualTo: recipeId)
            .get())
        .docs;

    final List<Product> products = await Future.wait(
      ingredientDocs
          .map(
            (doc) => _getProduct(doc.data()['productId'] as String),
          )
          .toList(),
    );
    final List<ExtendedIngredient> ingredients = [];
    for (int i = 0; i < ingredientDocs.length; i++) {
      ingredients.add(ExtendedIngredient(
        product: products[i],
        amount: (ingredientDocs[i].data()['amount'] as num).toDouble(),
        unit: ingredientDocs[i].data()['unit'] as String,
      ));
    }

    return ingredients;
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
}
