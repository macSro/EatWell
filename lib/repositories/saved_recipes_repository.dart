import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/repositories/recipe_list_repository.dart';
import 'package:eat_well_v1/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class SavedRecipesRepository {
  FirebaseFirestore _firestore;
  UserRepository _userRepository;
  RecipeListRepository _recipeListRepository;

  SavedRecipesRepository({
    @required FirebaseFirestore firestore,
    @required UserRepository userRepository,
    @required recipeListRepository,
  }) {
    this._firestore = firestore;
    this._userRepository = userRepository;
    this._recipeListRepository = recipeListRepository;
  }

  Future<List<Recipe>> fetchSavedRecipes() async {
    final ids = await _firestore
        .collection('saved-recipes')
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .get()
        .then(
          (snap) => snap.docs.map((doc) => doc.data()['recipeId'] as String).toList(),
        );

    final List<DocumentSnapshot> recipeDocs = await Future.wait(
        ids.map((recipeId) => _firestore.collection('recipes').doc(recipeId).get()).toList());

    return Future.wait(recipeDocs.map((doc) => _recipeListRepository.getRecipe(doc)).toList());
  }

  Future<void> saveRecipe(String recipeId) async {
    return _firestore.collection('saved-recipes').doc().set({
      'userId': _userRepository.getCurrentUser().uid,
      'recipeId': recipeId,
    });
  }

  Future<void> removeRecipeFromSaved(String recipeId) async {
    return _firestore
        .collection('saved-recipes')
        .where('recipeId', isEqualTo: recipeId)
        .where('userId', isEqualTo: _userRepository.getCurrentUser().uid)
        .limit(1)
        .get()
        .then(
          (snap) => _firestore.collection('saved-recipes').doc(snap.docs.first.id).delete(),
        );
  }
}
