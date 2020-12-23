import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/rating.dart';
import '../model/recipe.dart';
import 'user_repository.dart';

class RecipeListRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;

  RecipeListRepository(
      {@required FirebaseFirestore firestore,
      @required UserRepository userRepository}) {
    this._firestore = firestore;
    this._userRepository = userRepository;
  }

  Stream<Map<String, Rating>> fetchAllRatings() {
    return _firestore
        .collection('recipe-ratings')
        .orderBy('recipeId')
        .snapshots()
        .map((snapshot) {
      Map<String, Rating> result = {};
      snapshot.docs.forEach((doc) {
        final ratingData = doc.data();
        result[(ratingData['recipeId'] as String)] = Rating(
          points: (ratingData['points'] as num).toInt(),
          votes: (ratingData['votes'] as num).toInt(),
        );
      });
      return result;
    });
  }

  Stream<List<Recipe>> fetchAllRecipes() {
    return _firestore
        .collection('recipes')
        .orderBy(FieldPath.documentId)
        .snapshots()
        .asyncMap((snapshot) => Future.wait(snapshot.docs.map(
              (doc) {
                return _getRecipe(doc);
              },
            ).toList()));
  }

  Future<Recipe> _getRecipe(QueryDocumentSnapshot recipeDoc) async {
    final recipeId = recipeDoc.id;
    final recipeData = recipeDoc.data();
    final dishTypes = await _getRecipeDishTypes(recipeId);
    // final cuisines = await _getRecipeCuisines(recipeId);
    // final diets = await _getRecipeDiets(recipeId);

    return Recipe(
      id: recipeDoc.id,
      name: recipeData['name'],
      imageUrl: recipeData['imageUrl'],
      instructions: (recipeData['instructions'] as List)
          .map((instruction) => instruction as String)
          ?.toList(),
      readyInMinutes: recipeData['readyInMinutes'],
      servings: recipeData['servings'],
      dishTypes: dishTypes,
      rating: Rating(points: 10, votes: 2),
    );
  }

  Future<List<String>> _getRecipeDishTypes(String recipeId) async {
    final ids = await _firestore
        .collection('recipe-dish-types')
        .where('recipeId', isEqualTo: recipeId)
        .get()
        .then(
          (snapshot) => snapshot.docs
              .map((doc) => (doc.data()['dishTypeId'] as String))
              .toList(),
        );
    return Future.wait(ids.map((id) => _getRecipeDishTypeName(id)).toList());
  }

  Future<String> _getRecipeDishTypeName(String id) async {
    return _firestore
        .collection('dish-types')
        .doc(id)
        .get()
        .then((doc) => (doc.data()['name'] as String));
  }

  Future<List<String>> _getRecipeCuisines(String recipeId) async {}

  Future<List<String>> _getRecipeDiets(String recipeId) async {}

  // Stream<List<Recipe>> fetchAllRecipes() {
  //   //MAYBE JUST NEST ALL IN MULTIPLE THEN()
  //   return _firestore.collection(kRecipesCollectionName).snapshots().map(
  //         (snapshot) => snapshot.docs.map(
  //           (doc) {
  //             final recipeData = doc.data();
  //             List<ExtendedIngredient> ingredients;
  //             _firestore
  //                 .collection(kRecipeIngredientsCollectionName)
  //                 .where(kRecipeIngredientsFieldIdRecipe, isEqualTo: doc.id)
  //                 .get()
  //                 .then(
  //                   (snapshot) => snapshot.docs.isEmpty
  //                       ? print('empty')
  //                       : snapshot.docs.map(
  //                           (doc) {
  //                             Product product;
  //                             final ingredientData = doc.data();
  //                             _firestore
  //                                 .collection(kProductsCollectionName)
  //                                 .doc(ingredientData[
  //                                     kRecipeIngredientsFieldIdProduct])
  //                                 .get()
  //                                 .then(
  //                               (snapshot) {
  //                                 final productData = snapshot.data();
  //                                 product = Product(
  //                                   id: snapshot.id,
  //                                   name: productData[kProductsFieldName],
  //                                   imageUrl:
  //                                       productData[kProductsFieldImageUrl],
  //                                 );
  //                               },
  //                             );
  //                             ingredients.add(
  //                               ExtendedIngredient(
  //                                 product: product,
  //                                 amount: ingredientData[
  //                                     kRecipeIngredientsFieldAmount],
  //                                 unit: ingredientData[
  //                                     kRecipeIngredientsFieldUnit],
  //                               ),
  //                             );
  //                           },
  //                         ),
  //                 );
  //             Rating rating;
  //             _firestore
  //                 .collection(kRecipeRatingsCollectionName)
  //                 .where(kRecipeRatingsFieldIdRecipe, isEqualTo: doc.id)
  //                 .snapshots()
  //                 .map(
  //                   (snapshot) => snapshot.docs.map(
  //                     (doc) {
  //                       final ratingData = doc.data();
  //                       rating = Rating(
  //                         points: ratingData[kRecipeRatingsFieldPoints],
  //                         votes: ratingData[kRecipeRatingsFieldVotes],
  //                       );
  //                     },
  //                   ),
  //                 );
  //             List<String> dishTypes;
  //             _firestore
  //                 .collection(kRecipeDishTypesCollectionName)
  //                 .where(kRecipeDishTypesFieldIdRecipe, isEqualTo: doc.id)
  //                 .get()
  //                 .then(
  //                   (snapshot) => snapshot.docs.map(
  //                     (doc) {
  //                       _firestore
  //                           .collection(kDishTypesCollectionName)
  //                           .doc(doc.data()[kRecipeDishTypesFieldIdDishType])
  //                           .get()
  //                           .then(
  //                         (doc) {
  //                           dishTypes.add(doc.data()[kDishTypesFieldName]);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 );
  //             List<String> cuisines;
  //             _firestore
  //                 .collection(kRecipeCuisinesCollectionName)
  //                 .where(kRecipeCuisinesFieldIdRecipe, isEqualTo: doc.id)
  //                 .get()
  //                 .then(
  //                   (snapshot) => snapshot.docs.map(
  //                     (doc) {
  //                       _firestore
  //                           .collection(kCuisinesCollectionName)
  //                           .doc(doc.data()[kRecipeCuisinesFieldIdCuisine])
  //                           .get()
  //                           .then(
  //                         (doc) {
  //                           cuisines.add(doc.data()[kCuisinesFieldName]);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 );
  //             List<String> diets;
  //             _firestore
  //                 .collection(kRecipeDietsCollectionName)
  //                 .where(kRecipeDietsFieldIdRecipe, isEqualTo: doc.id)
  //                 .get()
  //                 .then(
  //                   (snapshot) => snapshot.docs.map(
  //                     (doc) {
  //                       _firestore
  //                           .collection(kDietsCollectionName)
  //                           .doc(doc.data()[kRecipeDietsFieldIdDiet])
  //                           .get()
  //                           .then(
  //                         (doc) {
  //                           diets.add(doc.data()[kDietsFieldName]);
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 );
  //             return Recipe(
  //               id: doc.id,
  //               name: recipeData[kRecipesFieldName],
  //               imageUrl: recipeData[kRecipesFieldImageUrl],
  //               instructions: (recipeData[kRecipesFieldInstructions] as List)
  //                   .map((instruction) => instruction as String)
  //                   ?.toList(),
  //               readyInMinutes: recipeData[kRecipesFieldReadyInMinutes],
  //               servings: recipeData[kRecipesFieldServings],
  //               ingredients: ingredients,
  //               rating: rating,
  //               dishTypes: dishTypes,
  //               cuisines: cuisines,
  //               diets: diets,
  //             );
  //           },
  //         ).toList(),
  //       );
  // }
}
