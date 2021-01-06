import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/pantry_repository.dart';
import 'package:eat_well_v1/repositories/recipe_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/recipe.dart';
import '../tools.dart';

class RecipeListRepository {
  FirebaseFirestore _firestore;
  RecipeRepository _recipeRepository;
  PantryRepository _pantryRepository;

  RecipeListRepository({
    @required FirebaseFirestore firestore,
    @required RecipeRepository recipeRepository,
    @required PantryRepository pantryRepository,
  }) {
    this._firestore = firestore;
    this._recipeRepository = recipeRepository;
    this._pantryRepository = pantryRepository;
  }

  Future<List<Recipe>> fetchAllRecipes() async {
    final futuresResults = await Future.wait(
      [
        _firestore.collection('recipes').get(),
        _pantryRepository.fetchPantry(),
      ],
    );

    final List<QueryDocumentSnapshot> recipeDocs = (futuresResults[0] as QuerySnapshot).docs;
    final List<ExtendedIngredient> pantryIngredients = futuresResults[1];

    final List<Recipe> recipes = await Future.wait(
      recipeDocs.map((doc) => getRecipe(recipeDoc: doc, pantryIngredients: pantryIngredients)).toList(),
    );

    return recipes;
  }

  Future<Recipe> getRecipe({DocumentSnapshot recipeDoc, List<ExtendedIngredient> pantryIngredients}) async {
    final recipeId = recipeDoc.id;
    final recipeData = recipeDoc.data();

    final futuresResults = await Future.wait([
      _recipeRepository.fetchRecipeIngredients(recipeId),
      _recipeRepository.fetchRecipeRating(recipeId),
      _getRecipeFilters(recipeId: recipeId, collectionName: 'dish-types', collectionIdName: 'dishTypeId'),
      _getRecipeFilters(recipeId: recipeId, collectionName: 'cuisines', collectionIdName: 'cuisineId'),
      _getRecipeFilters(recipeId: recipeId, collectionName: 'diets', collectionIdName: 'dietId'),
    ]);

    final List<ExtendedIngredient> ingredients = futuresResults[0];
    final double rating = futuresResults[1];
    final List<String> dishTypeNames = futuresResults[2];
    final List<String> cuisineNames = futuresResults[3];
    final List<String> dietNames = futuresResults[4];

    List<DishType> dishTypes = dishTypeNames
        .map(
          (name) => kDishTypes.keys.firstWhere(
            (dishType) => kDishTypes[dishType] == name,
            orElse: () => null,
          ),
        )
        .toList();
    dishTypes.removeWhere((dishType) => dishType == null);

    List<Cuisine> cuisines = cuisineNames
        .map(
          (name) => kCuisines.keys.firstWhere(
            (cuisine) => kCuisines[cuisine] == name,
            orElse: () => null,
          ),
        )
        .toList();
    cuisines.removeWhere((cuisine) => cuisine == null);

    List<Diet> diets = dietNames
        .map(
          (name) => kDiets.keys.firstWhere(
            (diet) => kDiets[diet] == name,
            orElse: () => null,
          ),
        )
        .toList();
    diets.removeWhere((diet) => diet == null);

    final inPantry = _countOwnedProducts(ingredients, pantryIngredients);
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
      inPantry: inPantry,
    );
  }

  int _countOwnedProducts(
    List<ExtendedIngredient> recipeIngredients,
    List<ExtendedIngredient> pantryIngredients,
  ) {
    if (pantryIngredients == null) return null;

    Map<Product, double> productAmounts = {};
    Map<Product, String> productUnits = {};
    pantryIngredients.forEach((ingredient) {
      productAmounts[ingredient.product] = ingredient.amount;
      productUnits[ingredient.product] = ingredient.unit;
    });

    int owned = 0;
    recipeIngredients.forEach((ingredient) {
      if (productAmounts.containsKey(ingredient.product) &&
          productAmounts[ingredient.product] >= ingredient.amount &&
          Tools.getUnitShort(productUnits[ingredient.product]) == Tools.getUnitShort(ingredient.unit))
        owned++;
    });
    return owned;
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
}
