import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../model/recipe.dart';
import '../../repositories/recipe_list_repository.dart';
import '../../widgets/screens/filters/recipe_list_filters.dart';
import 'recipe_list_event.dart';
import 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  RecipeListRepository _recipeListRepository;

  RecipeListBloc({
    @required recipeListRepository,
    @required recipeRepository,
    @required userRepository,
  }) : super(RecipeListInitial()) {
    _recipeListRepository = recipeListRepository;
  }

  @override
  Stream<RecipeListState> mapEventToState(RecipeListEvent event) async* {
    if (event is FetchRecipes)
      yield* _fetchAllRecipes();
    else if (event is FilterAndSortRecipes)
      yield* _filterAndSortRecipes(event.allRecipes, event.filteredRecipes, event.filters);
  }

  Stream<RecipeListState> _fetchAllRecipes() async* {
    yield RecipeListLoading();

    final List<Recipe> recipes = await _recipeListRepository.fetchAllRecipes();
    yield RecipesFetched(allRecipes: recipes, filteredRecipes: recipes);
  }

  Stream<RecipeListState> _filterAndSortRecipes(
    List<Recipe> allRecipes,
    List<Recipe> filteredRecipes,
    RecipeListFilters filters,
  ) async* {
    yield RecipeListLoading();

    List<Recipe> newFilteredRecipes = _sort(
      _filter(allRecipes, filters.dishTypes, filters.cuisines, filters.diets),
      filters.sortBy,
    );

    yield RecipesFetched(allRecipes: allRecipes, filteredRecipes: newFilteredRecipes);
  }

  List<Recipe> _sort(List<Recipe> recipes, SortBy sortBy) {
    Comparator<Recipe> comparator;
    switch (sortBy) {
      case SortBy.NameAsc:
        comparator = (r1, r2) => r1.name.compareTo(r2.name);
        break;
      case SortBy.NameDesc:
        comparator = (r1, r2) => r2.name.compareTo(r1.name);
        break;
      case SortBy.PantryProducts:
        comparator = (r1, r2) {
          if (r1.inPantry == 0 && r2.inPantry == 0)
            return r1.ingredients.length.compareTo(r2.ingredients.length);
          else {
            if (r1.ingredients.length == 0 && r2.ingredients.length != 0)
              return 1;
            else if (r1.ingredients.length == 0 && r2.ingredients.length == 0)
              return 0;
            else if (r1.ingredients.length != 0 && r2.ingredients.length != 0)
              return (r2.inPantry / r2.ingredients.length).compareTo(r1.inPantry / r1.ingredients.length);
            else
              return -1;
          }
        };
        break;
      case SortBy.Rating:
        comparator = (r1, r2) => r2.rating.compareTo(r1.rating);
        break;
      case SortBy.PreparationTimeAsc:
        comparator = (r1, r2) => r1.readyInMinutes.compareTo(r2.readyInMinutes);
        break;
      case SortBy.PreparationTimeDesc:
        comparator = (r1, r2) => r2.readyInMinutes.compareTo(r1.readyInMinutes);
        break;
      case SortBy.ServingsAsc:
        comparator = (r1, r2) => r1.servings.compareTo(r2.servings);
        break;
      case SortBy.ServingsDesc:
        comparator = (r1, r2) => r2.servings.compareTo(r1.servings);
        break;
      default:
        comparator = (r1, r2) => r1.name.compareTo(r2.name);
    }
    recipes.sort(comparator);
    return recipes;
  }

  List<Recipe> _filter(
    List<Recipe> recipes,
    Map<DishType, bool> dishTypes,
    Map<Cuisine, bool> cuisines,
    Map<Diet, bool> diets,
  ) {
    List<DishType> dishTypeFilters = dishTypes.entries.map((filter) {
      if (filter.value) return filter.key;
    }).toList();
    dishTypeFilters.removeWhere((element) => element == null);

    List<Cuisine> cuisineFilters = cuisines.entries.map((filter) {
      if (filter.value) return filter.key;
    }).toList();
    cuisineFilters.removeWhere((element) => element == null);

    List<Diet> dietFilters = diets.entries.map((filter) {
      if (filter.value) return filter.key;
    }).toList();
    dietFilters.removeWhere((element) => element == null);

    List<Recipe> newRecipes = [];

    if (dishTypeFilters.isEmpty && cuisineFilters.isEmpty && dietFilters.isEmpty)
      newRecipes.addAll(recipes);
    else {
      int _dishTypesCount;
      int _cuisinesCount;
      int _dietsCount;
      recipes.forEach((recipe) {
        _dishTypesCount = 0;
        _cuisinesCount = 0;
        _dietsCount = 0;

        dietFilters.forEach((diet) {
          if (recipe.diets.contains(diet)) {
            _dietsCount++;
          }
        });
        if (_dietsCount == dietFilters.length || dietFilters.isEmpty) {
          if (dishTypeFilters.isEmpty && cuisineFilters.isEmpty) {
            newRecipes.add(recipe);
          } else {
            dishTypeFilters.forEach((dishType) {
              if (recipe.dishTypes.contains(dishType)) {
                _dishTypesCount++;
              }
            });
            if (_dishTypesCount > 0 || dishTypeFilters.isEmpty) {
              if (cuisineFilters.isEmpty) {
                newRecipes.add(recipe);
              } else {
                cuisineFilters.forEach((cuisine) {
                  if (recipe.cuisines.contains(cuisine)) {
                    _cuisinesCount++;
                  }
                });
                if (_cuisinesCount > 0) newRecipes.add(recipe);
              }
            }
          }
        }
      });
    }

    return newRecipes;
  }
}
