import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/repositories/recipe_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/recipe.dart';
import 'user_repository.dart';

class RecipeListRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;
  RecipeRepository _recipeRepository;

  RecipeListRepository({
    @required FirebaseFirestore firestore,
    @required UserRepository userRepository,
    @required RecipeRepository recipeRepository,
  }) {
    this._firestore = firestore;
    this._userRepository = userRepository;
    this._recipeRepository = recipeRepository;
  }

  Future<List<Recipe>> fetchAllRecipes() async {
    final recipeDocs = (await _firestore.collection('recipes').get()).docs;

    final List<Recipe> recipes = await Future.wait(recipeDocs.map((doc) => _getRecipe(doc)).toList());

    return recipes;
  }

  Future<Recipe> _getRecipe(QueryDocumentSnapshot recipeDoc) async {
    final recipeId = recipeDoc.id;
    final recipeData = recipeDoc.data();
    final ingredients = await _recipeRepository.fetchRecipeIngredients(recipeId);
    final rating = await _recipeRepository.fetchRecipeRating(recipeId);
    final dishTypes = await _getRecipeFilters(
        recipeId: recipeId, collectionName: 'dish-types', collectionIdName: 'dishTypeId');
    final cuisines = await _getRecipeFilters(
        recipeId: recipeId, collectionName: 'cuisines', collectionIdName: 'cuisineId');
    final diets =
        await _getRecipeFilters(recipeId: recipeId, collectionName: 'diets', collectionIdName: 'dietId');

    return Recipe(
      id: recipeDoc.id,
      name: recipeData['name'],
      imageUrl: recipeData['imageUrl'],
      ingredients: ingredients,
      instructions:
          (recipeData['instructions'] as List).map((instruction) => instruction as String)?.toList(),
      readyInMinutes: recipeData['readyInMinutes'],
      servings: recipeData['servings'],
      rating: rating,
      dishTypes: dishTypes,
      cuisines: cuisines,
      diets: diets,
    );
  }

  Future<List<String>> _getRecipeFilters({
    @required String recipeId,
    @required String collectionName,
    @required String collectionIdName,
  }) async {
    final ids = await _firestore
        .collection('recipe-$collectionName')
        .where('recipeId', isEqualTo: recipeId)
        .get()
        .then(
          (snapshot) => snapshot.docs.map((doc) => (doc.data()[collectionIdName] as String)).toList(),
        );
    return Future.wait(ids.map((id) => _getRecipeFilterName(collectionName, id)).toList());
  }

  Future<String> _getRecipeFilterName(String collectionName, String id) {
    return _firestore.collection(collectionName).doc(id).get().then((doc) => (doc.data()['name'] as String));
  }

  // Stream<Map<String, double>> fetchAllRatings() {
  //   return _firestore.collection('recipe-ratings').orderBy('recipeId').snapshots().map((snapshot) {
  //     Map<String, double> result = {};
  //     snapshot.docs.forEach((doc) {
  //       final ratingData = doc.data();
  //       result[(ratingData['recipeId'] as String)] = (ratingData['rating'] as num).toDouble();
  //     });
  //     return result;
  //   });
  // }

  // Stream<List<Recipe>> fetchAllRecipes() {
  //   return _firestore
  //       .collection('recipes')
  //       .orderBy(FieldPath.documentId)
  //       .snapshots()
  //       .asyncMap((snapshot) => Future.wait(snapshot.docs.map(
  //             (doc) {
  //               return _getRecipe(doc);
  //             },
  //           ).toList()));
  // }

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
