import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import '../../../bloc/my_recipes/created_recipes/created_recipes_event.dart';
import '../../../constants.dart';
import '../../../model/extended_ingredient.dart';
import '../../../model/product.dart';
import '../../../model/rating.dart';
import '../../../model/recipe.dart';
import '../../misc/circle_icon_button.dart';
import '../../misc/scaffold.dart';
import 'create_recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      //hasAppBar: false,
      title: 'Create a new recipe',
      hasDrawer: false,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 16),
                CreateRecipeForm(),
              ],
            ),
          ),
          /*Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16),
            child: _getBackButton(context),
          ),*/
          /*Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(16),
            child: _getSaveButton(context),
          ),*/
        ],
      ),
    );
  }

  Widget _getBackButton(context) {
    return CircleIconButton(
      iconButton: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      color: kPrimaryColor.withOpacity(0.65),
    );
  }

  Widget _getSaveButton(context) {
    return CircleIconButton(
      iconButton: IconButton(
        icon: Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () {
          BlocProvider.of<CreatedRecipesBloc>(context).add(
            CreateRecipe(
              recipe: Recipe(
                id: '658703',
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
              ),
            ),
          );
        },
      ),
      color: Colors.amber.withOpacity(0.65),
    );
  }
}
