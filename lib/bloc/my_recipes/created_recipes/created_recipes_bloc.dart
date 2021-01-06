import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/repositories/created_recipes_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../model/recipe.dart';
import 'created_recipes_event.dart';
import 'created_recipes_state.dart';

class CreatedRecipesBloc extends Bloc<CreatedRecipesEvent, CreatedRecipesState> {
  CreatedRecipesRepository _createdRecipesRepository;

  CreatedRecipesBloc({@required CreatedRecipesRepository createdRecipesRepository})
      : super(CreatedRecipesInitial()) {
    this._createdRecipesRepository = createdRecipesRepository;
  }

  @override
  Stream<CreatedRecipesState> mapEventToState(event) async* {
    if (event is FetchCreatedRecipes) yield* _fetchCreatedRecipes();
  }

  Stream<CreatedRecipesState> _fetchCreatedRecipes() async* {
    yield CreatedRecipesLoading();

    final List<Recipe> recipes = await _createdRecipesRepository.fetchCreatedRecipes();

    yield CreatedRecipesFetched(recipes: recipes);
  }
}
