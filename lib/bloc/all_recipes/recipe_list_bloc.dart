import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../model/extended_ingredient.dart';
import '../../model/product.dart';
import '../../model/recipe.dart';
import '../../repositories/recipe_list_repository.dart';
import '../../widgets/screens/filters/recipe_list_filter.dart';
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
    else if (event is SortRecipes)
      yield* _sortRecipes(event.recipes, event.sortBy);
    else if (event is FilterRecipes) yield* _filterRecipes(event.recipes, event.filters);
  }

  Stream<RecipeListState> _fetchAllRecipes() async* {
    yield RecipeListLoading();

    final List<Recipe> recipes = await _recipeListRepository.fetchAllRecipes();
    yield RecipesFetched(recipes: recipes);
    // Stream<List<Recipe>> recipesStream = _recipeListRepository.fetchAllRecipes();
    // Stream<Map<String, double>> ratingsStream = _recipeListRepository.fetchAllRatings();
    // StreamZip combinedStreams = StreamZip([recipesStream, ratingsStream]);
    // combinedStreams.listen((snaps) {
    //   List<Recipe> recipesBase = snaps[0];
    //   Map<String, double> ratings = snaps[1];

    //   List<Recipe> recipesResult = [];
    //   recipesBase.forEach((recipe) {
    //     //List<ExtendedIngredient> ingredients = await _recipeRepository.fetchRecipeIngredients(recipe.id);
    //     recipesResult.add(
    //       recipe.copyWith(rating: ratings[recipe.id]),
    //     );
    //   });
    //   add(UpdateRecipes(recipes: recipesResult));
    // });
  }

  Stream<RecipeListState> _sortRecipes(List<Recipe> recipes, SortBy sortBy) async* {
    print(recipes.map((recipe) => recipe.name).toList());
    Comparator<Recipe> comparator;
    switch (sortBy) {
      case SortBy.AZ:
        comparator = (r1, r2) => r1.name.compareTo(r2.name);
        break;
      case SortBy.ZA:
        comparator = (r1, r2) => r2.name.compareTo(r1.name);
        break;
      case SortBy.Rating:
        comparator = (r1, r2) => r2.rating.compareTo(r1.rating);
        break;
      case SortBy.PreparationTime:
        comparator = (r1, r2) => r1.readyInMinutes.compareTo(r2.readyInMinutes);
        break;
      case SortBy.Servings:
        comparator = (r1, r2) => r1.servings.compareTo(r2.servings);
        break;
      case SortBy.PantryProducts:
        comparator = (r1, r2) => r2.inPantry.compareTo(r1.inPantry);
        break;
      default:
        comparator = (r1, r2) => r1.name.compareTo(r2.name);
    }
    recipes.sort(comparator);
    print(recipes.map((recipe) => recipe.name).toList());
    yield RecipesFetched(recipes: recipes);
  }

  Stream<RecipeListState> _filterRecipes(List<Recipe> recipes, RecipeListFilters filters) async* {
    //TODO
  }
}
