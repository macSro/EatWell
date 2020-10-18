import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/ingredient.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/model/recipe.dart';

class RecipeListBloc extends Bloc<RecipeListEvent, RecipeListState> {
  RecipeListBloc() : super(RecipeListInitial());

  @override
  Stream<RecipeListState> mapEventToState(RecipeListEvent event) async* {
    if (event is FetchAllRecipes) yield* _fetchAllRecipes();
  }

  Stream<RecipeListState> _fetchAllRecipes() async* {
    yield RecipeListLoading();
    //TODO: FROM FIREBASE final recipes = await fetchAllRecipes();
    final recipes = await Future.delayed(
      Duration(seconds: 2),
      () {
        var recipe1 = Recipe(
          id: 658703,
          name: 'Roasted Vegetable Tacos',
          imageUrl: kRecipeImageUrlBasePath + '658703-636x393.jpg',
          readyInMinutes: 30,
          servings: 4,
          rating: Rating(points: 20, votes: 4),
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
              ingredient: Ingredient(
                id: 1,
                name: 'apple',
                imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
              ),
              amount: 2.0,
              unit: 'cups',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 2,
                name: 'broccoli',
                imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
              ),
              amount: 200.0,
              unit: 'ml',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 3,
                name: 'garlic',
                imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
              ),
              amount: 1.0,
              unit: 'tbsp',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 4,
                name: 'milk',
                imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
              ),
              amount: 1.0,
              unit: 'tsp',
            ),
          ],
        );
        var recipe2 = Recipe(
          id: 653068,
          name: 'New Waldorf Salad',
          imageUrl: kRecipeImageUrlBasePath + '653068-636x393.jpg',
          readyInMinutes: 45,
          servings: 4,
          rating: Rating(points: 0, votes: 0),
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
              ingredient: Ingredient(
                id: 1,
                name: 'apple',
                imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
              ),
              amount: 2.0,
              unit: 'cups',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 2,
                name: 'broccoli',
                imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
              ),
              amount: 200.0,
              unit: 'ml',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 3,
                name: 'garlic',
                imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
              ),
              amount: 1.0,
              unit: 'tbsp',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 4,
                name: 'milk',
                imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
              ),
              amount: 1.0,
              unit: 'tsp',
            ),
          ],
        );
        var recipe3 = Recipe(
          id: 641255,
          name: 'Dark Chocolate Chunk Quinoa Granola Bars',
          imageUrl: kRecipeImageUrlBasePath + '641255-636x393.jpg',
          readyInMinutes: 45,
          servings: 14,
          rating: Rating(points: 10, votes: 4),
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
              ingredient: Ingredient(
                id: 1,
                name: 'apple',
                imageUrl: kIngredientImageUrlBasePath + 'apple.jpg',
              ),
              amount: 2.0,
              unit: 'cups',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 2,
                name: 'broccoli',
                imageUrl: kIngredientImageUrlBasePath + 'broccoli.jpg',
              ),
              amount: 200.0,
              unit: 'ml',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 3,
                name: 'garlic',
                imageUrl: kIngredientImageUrlBasePath + 'garlic.jpg',
              ),
              amount: 1.0,
              unit: 'tbsp',
            ),
            ExtendedIngredient(
              ingredient: Ingredient(
                id: 4,
                name: 'milk',
                imageUrl: kIngredientImageUrlBasePath + 'milk.jpg',
              ),
              amount: 1.0,
              unit: 'tsp',
            ),
          ],
        );
        print('fetched all recipes!!!');
        return [recipe1, recipe2, recipe3];
      },
    );
    yield AllRecipesFetched(recipes: recipes);
  }
}
