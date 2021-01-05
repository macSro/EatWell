import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/extended_ingredient.dart';
import '../model/product.dart';
import 'user_repository.dart';

class RecipeRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  RecipeRepository({@required FirebaseFirestore firestore, @required UserRepository userRepository}) {
    this._firestore = firestore;
    this._userRepository = userRepository;
  }

  Future<List<ExtendedIngredient>> fetchRecipeIngredients(String recipeId) async {
    final ingredientDocs =
        (await _firestore.collection('recipe-ingredients').where('recipeId', isEqualTo: recipeId).get()).docs;

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

  Future<double> fetchRecipeRating(String recipeId) async {
    QuerySnapshot snap =
        await _firestore.collection('recipe-ratings').where('recipeId', isEqualTo: recipeId).get();
    double rating = 0.0;
    if (snap.docs.isEmpty) return rating;

    snap.docs.forEach((doc) {
      rating += (doc.data()['rating'] as num).toDouble();
    });

    return rating / snap.docs.length;
  }

  Future<int> fetchUserRating(String recipeId) async {
    String userRatingDocId = await getUserRatingDocId(recipeId, _userRepository.getCurrentUser().uid);

    return userRatingDocId != null
        ? await (_firestore.collection('recipe-ratings').doc(userRatingDocId).get())
            .then((doc) => (doc.data()['rating'] as num).toInt())
        : 0;
  }

  Future<void> updateUserRating(String recipeId, int rating) async {
    String userRatingDocId = await getUserRatingDocId(recipeId, _userRepository.getCurrentUser().uid);

    return userRatingDocId != null
        ? _firestore.collection('recipe-ratings').doc(userRatingDocId).update({'rating': rating})
        : _firestore.collection('recipe-ratings').doc().set({
          'recipeId': recipeId,
          'userId': _userRepository.getCurrentUser().uid,
          'rating': rating,
        });
  }

  Future<void> deleteUserRating(String recipeId) async {
    String userRatingDocId = await getUserRatingDocId(recipeId, _userRepository.getCurrentUser().uid);

    return userRatingDocId != null
        ? _firestore.collection('recipe-ratings').doc(userRatingDocId).delete()
        : null;
  }

  Future<String> getUserRatingDocId(String recipeId, String userId) async {
    QuerySnapshot snap = await _firestore
        .collection('recipe-ratings')
        .where('recipeId', isEqualTo: recipeId)
        .where('userId', isEqualTo: userId)
        .limit(1) //will always result with 1 or 0
        .get();
    if (snap.docs.isEmpty)
      return null;
    else
      return snap.docs.first.id;
  }

  Future<bool> isRecipeSaved(String recipeId) async {
    return _firestore
        .collection('saved-recipes')
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .where('recipeId', isEqualTo: recipeId)
        .get()
        .then((snap) => snap.docs.isEmpty ? false : true);
  }
}
