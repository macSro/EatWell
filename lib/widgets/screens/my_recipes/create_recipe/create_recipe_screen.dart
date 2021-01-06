import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:flutter/material.dart';

import '../../../misc/scaffold.dart';
import 'create_recipe_form.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Create a new recipe',
      hasDrawer: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            CreateRecipeForm(
              initIngredients: [
                ExtendedIngredient(
                  product: Product(
                    id: '1',
                    name: 'test',
                    imageUrl: 'https://spoonacular.com/cdn/ingredients_100x100/apple.jpg',
                  ),
                  amount: 20,
                  unit: 'g',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
