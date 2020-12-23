import 'package:eat_well_v1/widgets/misc/fullscreen_dialog.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/screens/pantry/add_product_form.dart';
import 'package:flutter/material.dart';

import '../../misc/scaffold.dart';

class PantryScreen extends StatelessWidget {
  static const routeName = '/pantry';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Pantry',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: _getProducts(),
      ),
      floatingActionButton: _getAddButton(context),
    );
  }

  ListView _getProducts() {
    return ListView(
      children: [
        IngredientListTile(
          imageUrl: 'https://spoonacular.com/cdn/ingredients_100x100/garlic.jpg',
          name: 'garlic',
          amount: 4,
          unit: 'clove',
          expDate: DateTime(2020, 11, 22),
        ),
        Divider(),
        IngredientListTile(
          imageUrl: 'https://spoonacular.com/cdn/ingredients_100x100/apple.jpg',
          name: 'apple',
          amount: 4,
          unit: '',
          expDate: DateTime(2020, 11, 22),
        ),
        Divider(),
        IngredientListTile(
          imageUrl: 'https://spoonacular.com/cdn/ingredients_100x100/flour.jpg',
          name: 'flour',
          amount: 1,
          unit: 'kg',
          expDate: DateTime(2020, 11, 22),
        ),
        Divider(),
      ],
    );
  }

  FloatingActionButton _getAddButton(context) => FloatingActionButton(
        onPressed: () => showFullscreenDialog(
          context: context,
          child: AddProductForm(),
          title: 'Add a product to your pantry!',
          closeButton: _getCloseAddProductFormButton(context),
        ),
        child: Icon(Icons.add_rounded),
      );

  Widget _getCloseAddProductFormButton(context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 16),
      child: RaisedButton(
        onPressed: () => Navigator.pop(context),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Close',
              style: TextStyle().copyWith(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
