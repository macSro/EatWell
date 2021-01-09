import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/repositories/recipe_list_repository.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../tools.dart';

class CreatedRecipesRepository {
  FirebaseFirestore _firestore;
  FirebaseStorage _storage;
  UserRepository _userRepository;
  RecipeListRepository _recipeListRepository;

  CreatedRecipesRepository({
    @required FirebaseFirestore firestore,
    @required FirebaseStorage storage,
    @required UserRepository userRepository,
    @required recipeListRepository,
  }) {
    this._firestore = firestore;
    this._storage = storage;
    this._userRepository = userRepository;
    this._recipeListRepository = recipeListRepository;
  }

  Future<List<Recipe>> fetchCreatedRecipes() async {
    final ids = await _firestore
        .collection('created-recipes')
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .get()
        .then(
          (snap) => snap.docs.map((doc) => doc.data()['recipeId'] as String).toList(),
        );

    final List<DocumentSnapshot> recipeDocs = await Future.wait(
        ids.map((recipeId) => _firestore.collection('recipes').doc(recipeId).get()).toList());

    return Future.wait(recipeDocs.map((doc) => _recipeListRepository.getRecipe(recipeDoc: doc)).toList());
  }

  Future<Recipe> createRecipe({
    @required String name,
    @required File imageFile,
    @required List<ExtendedIngredient> ingredients,
    @required List<DishType> dishTypes,
    @required List<Cuisine> cuisines,
    @required List<Diet> diets,
    @required List<String> instructions,
    @required int readyInMinutes,
    @required int servings,
  }) async {
    final String imageUrl = (await _uploadImage(name, imageFile)) ?? kRecipeImageUrlBasePath + 'unknown.jpg';

    final docRef = await _firestore.collection('recipes').add({
      'name': name,
      'imageUrl': imageUrl,
      'instructions': instructions,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
    }).catchError((error) {
      print(error.toString());
      return null;
    });

    final List<String> dishTypeNames = dishTypes.map((dishType) => kDishTypes[dishType]).toList();
    final List<String> cuisineNames = cuisines.map((cuisine) => kCuisines[cuisine]).toList();
    final List<String> dietNames = diets.map((diet) => kDiets[diet]).toList();

    List<Future> futures = [];
    dishTypeNames.forEach((name) => futures.add(_addFilter(docRef.id, 'dish-types', name)));
    cuisineNames.forEach((name) => futures.add(_addFilter(docRef.id, 'cuisines', name)));
    dietNames.forEach((name) => futures.add(_addFilter(docRef.id, 'diets', name)));
    ingredients.forEach((ingredient) => futures.add(_addIngredient(docRef.id, ingredient)));

    await Future.wait(futures);

    return _firestore
        .collection('created-recipes')
        .doc()
        .set({
          'recipeId': docRef.id,
          'userId': _userRepository.getCurrentUser().uid,
        })
        .then(
          (_) => Recipe(
            id: docRef.id,
            name: name,
            imageUrl: imageUrl,
            ingredients: ingredients,
            dishTypes: dishTypes,
            cuisines: cuisines,
            diets: diets,
            instructions: instructions,
            readyInMinutes: readyInMinutes,
            servings: servings,
            rating: 0.0,
          ),
        )
        .catchError((error) {
          print(error.toString());
          return null;
        });
  }

  Future<void> _addFilter(String recipeId, String collectionName, String name) async {
    return _firestore
        .collection('recipes')
        .doc(recipeId)
        .collection(collectionName)
        .doc()
        .set({'name': name});
  }

  Future<void> _addIngredient(String recipeId, ExtendedIngredient ingredient) async {
    return _firestore.collection('recipe-ingredients').doc().set({
      'recipeId': recipeId,
      'productId': ingredient.product.id,
      'amount': ingredient.amount,
      'unit': ingredient.unit,
    });
  }

  Future<String> _uploadImage(String productName, File file) async {
    if (file == null) return null;

    Reference ref = _storage.ref().child('recipe-images/${Tools.getImageName(productName)}');

    return ref.putFile(file).then((_) => ref.getDownloadURL()).catchError((error) => null);
  }

  Future<void> deleteRecipe(String recipeId) async {
    return Future.wait([
      _firestore.collection('recipes').doc(recipeId).delete(),
      _firestore
          .collection('created-recipes')
          .where('recipeId', isEqualTo: recipeId)
          .limit(1)
          .get()
          .then((snap) => _firestore.collection('created-recipes').doc(snap.docs.first.id).delete()),
    ]);
  }
}
