import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/repositories/diet_repository.dart';
import 'package:eat_well_v1/repositories/pantry_repository.dart';
import 'package:eat_well_v1/repositories/recipe_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/recipe.dart';
import '../tools.dart';

class RecipeListRepository {
  FirebaseFirestore _firestore;
  RecipeRepository _recipeRepository;
  PantryRepository _pantryRepository;
  DietRepository _dietRepository;

  RecipeListRepository({
    @required FirebaseFirestore firestore,
    @required RecipeRepository recipeRepository,
    @required PantryRepository pantryRepository,
    @required DietRepository dietRepository,
  }) {
    this._firestore = firestore;
    this._recipeRepository = recipeRepository;
    this._pantryRepository = pantryRepository;
    this._dietRepository = dietRepository;
  }

  Future<List<Recipe>> fetchAllRecipes() async {
    final futuresResults = await Future.wait(
      [
        _firestore.collection('recipes').orderBy('name').get(),
        _pantryRepository.fetchPantry(),
        _dietRepository.fetchBannedProducts(),
      ],
    );

    final List<QueryDocumentSnapshot> recipeDocs = (futuresResults[0] as QuerySnapshot).docs;
    final List<ExtendedIngredient> pantryIngredients = futuresResults[1];
    final List<Product> bannedProducts = futuresResults[2];

    final List<Recipe> recipes = await Future.wait(
      recipeDocs
          .map((doc) => getRecipe(
                recipeDoc: doc,
                pantryIngredients: pantryIngredients,
                bannedProducts: bannedProducts,
              ))
          .toList(),
    );

    recipes.removeWhere((element) => element == null);

    return recipes;
  }

  Future<Recipe> getRecipe({
    DocumentSnapshot recipeDoc,
    List<ExtendedIngredient> pantryIngredients,
    List<Product> bannedProducts,
  }) async {
    final recipeId = recipeDoc.id;
    final recipeData = recipeDoc.data();

    final List<ExtendedIngredient> ingredients = await _recipeRepository.fetchRecipeIngredients(recipeId);

    if (bannedProducts != null) {
      final List<String> bannedProductNames = bannedProducts.map((product) => product.name).toList();
      final List<String> ingredientNames = ingredients.map((ingredient) => ingredient.product.name).toList();

      bool banned = false;
      ingredientNames.forEach((ingredientName) {
        if (bannedProductNames.contains(ingredientName)) {
          banned = true;
        }
      });
      
      if (banned) return null;
    }

    final futuresResults = await Future.wait([
      _recipeRepository.fetchRecipeRating(recipeId),
      _getRecipeDishTypes(recipeId),
      _getRecipeCuisines(recipeId),
      _getRecipeDiets(recipeId),
    ]);

    final double rating = futuresResults[0];
    final List<DishType> dishTypes = futuresResults[1];
    final List<Cuisine> cuisines = futuresResults[2];
    final List<Diet> diets = futuresResults[3];
    
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

  Future<List<DishType>> _getRecipeDishTypes(String recipeId) async {
    final List<String> dishTypeNames = await _firestore
        .collection('recipes')
        .doc(recipeId)
        .collection('dish-types')
        .get()
        .then((snap) => snap.docs.map((doc) => doc.data()['name'] as String).toList());

    if (dishTypeNames == null) return null;

    List<DishType> dishTypes = dishTypeNames
        .map(
          (name) => kDishTypes.keys.firstWhere(
            (dishType) => kDishTypes[dishType] == name,
            orElse: () => null,
          ),
        )
        .toList();
    dishTypes.removeWhere((dishType) => dishType == null);

    return dishTypes;
  }

  Future<List<Cuisine>> _getRecipeCuisines(String recipeId) async {
    final List<String> cuisineNames = await _firestore
        .collection('recipes')
        .doc(recipeId)
        .collection('cuisines')
        .get()
        .then((snap) => snap.docs.map((doc) => doc.data()['name'] as String).toList());

    if (cuisineNames == null) return null;

    List<Cuisine> cuisines = cuisineNames
        .map(
          (name) => kCuisines.keys.firstWhere(
            (cuisine) => kCuisines[cuisine] == name,
            orElse: () => null,
          ),
        )
        .toList();
    cuisines.removeWhere((cuisine) => cuisine == null);

    return cuisines;
  }

  Future<List<Diet>> _getRecipeDiets(String recipeId) async {
    final List<String> dietNames = await _firestore
        .collection('recipes')
        .doc(recipeId)
        .collection('diets')
        .get()
        .then((snap) => snap.docs.map((doc) => doc.data()['name'] as String).toList());

    if (dietNames == null) return null;

    List<Diet> diets = dietNames
        .map(
          (name) => kDiets.keys.firstWhere(
            (diet) => kDiets[diet] == name,
            orElse: () => null,
          ),
        )
        .toList();
    diets.removeWhere((diet) => diet == null);

    return diets;
  }
}
