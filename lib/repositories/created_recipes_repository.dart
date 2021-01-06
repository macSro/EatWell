import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/repositories/recipe_list_repository.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class CreatedRecipesRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;
  RecipeListRepository _recipeListRepository;

  CreatedRecipesRepository({
    @required FirebaseFirestore firestore,
    @required UserRepository userRepository,
    @required recipeListRepository,
  }) {
    this._firestore = firestore;
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
}