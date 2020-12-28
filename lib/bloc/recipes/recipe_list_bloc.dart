import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../../model/extended_ingredient.dart';
import '../../model/product.dart';
import '../../model/recipe.dart';
import '../../repositories/recipe_list_repository.dart';
import '../../repositories/recipe_repository.dart';
import '../../repositories/user_repository.dart';
import '../../widgets/screens/filters/recipe_list_filter.dart';
import 'recipe_list_event.dart';
import 'recipe_list_state.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  RecipeListRepository _recipeListRepository;
  RecipeRepository _recipeRepository;
  UserRepository _userRepository;

  RecipeListBloc({
    @required recipeListRepository,
    @required recipeRepository,
    @required userRepository,
  }) : super(RecipeListInitial()) {
    _recipeListRepository = recipeListRepository;
    _recipeRepository = recipeRepository;
    _userRepository = userRepository;
  }

  @override
  Stream<RecipeListState> mapEventToState(RecipeListEvent event) async* {
    if (event is FetchAllRecipes)
      yield* _fetchAllRecipes();
    else if (event is FetchFilteredRecipes)
      yield* _fetchFilteredRecipes(event.filters);
    else if (event is UpdateRecipes) yield* _updateRecipes(event.recipes);
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

  Stream<RecipeListState> _fetchFilteredRecipes(RecipeListFilters filters) async* {
    yield RecipeListLoading();
    //TODO: FIREBASE  recipes = await fetch filtered
    final recipes = await Future.delayed(
      Duration(seconds: 2),
      () {
        var recipe1 = Recipe(
          id: '653068',
          name: 'New Waldorf Salad',
          imageUrl: kRecipeImageUrlBasePath + '653068-636x393.jpg',
          readyInMinutes: 45,
          servings: 4,
          rating: 0.0,
          instructions: [
            'Preheat the oven to 375 degrees. In a casserole dish, add the chopped sweet potato, pasilla pepper, bell pepper and onion. In a small bowl, combine the chicken stock, oil and vinegar.',
            'Mix to combine and pour evenly over the vegetables.',
            'Sprinkle the chili powder, cumin, paprika, and salt over the veggies and stir.',
            'Bake in for 30 minutes.',
            'Remove the casserole dish from the oven, stir everything well, increase oven heat to 400 and bake 7 to 10 more minutes.',
            'Remove from oven and allow to cool slightly.While the vegetables are roasting in the oven, you can cook the corn by boiling it in hot water for 5 to 7 minutes or grilling it.  Carefully remove the kernels with a sharp knife.',
            'Heat the black beans in a sauce pan. Chop the goat cheese.',
            'Heat your favorite tortillas, place desired amount of ingredients in the tortillas and add extra goodies such as guacamole, salsa and green onion if desire.',
          ],
          ingredients: [
            ExtendedIngredient(
              product: Product(
                id: '1',
                name: 'apple',
                imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
              ),
              amount: 2.0,
              unit: 'cups',
            ),
            ExtendedIngredient(
              product: Product(
                id: '2',
                name: 'broccoli',
                imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
              ),
              amount: 200.0,
              unit: 'ml',
            ),
            ExtendedIngredient(
              product: Product(
                id: '3',
                name: 'garlic',
                imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
              ),
              amount: 1.0,
              unit: 'tbsp',
            ),
            ExtendedIngredient(
              product: Product(
                id: '4',
                name: 'milk',
                imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
              ),
              amount: 1.0,
              unit: 'tsp',
            ),
          ],
        );
        return [recipe1];
      },
    );
    yield RecipesFetched(recipes: recipes);
  }

  Stream<RecipeListState> _updateRecipes(List<Recipe> recipes) async* {
    yield RecipesFetched(recipes: recipes);
  }
}
