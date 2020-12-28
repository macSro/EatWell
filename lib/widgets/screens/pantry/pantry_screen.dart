import 'package:eat_well_v1/bloc/pantry/pantry_bloc.dart';
import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../misc/fullscreen_dialog.dart';
import '../../misc/ingredient_list_tile.dart';
import '../../misc/scaffold.dart';
import 'add_product_form.dart';

class PantryScreen extends StatelessWidget {
  static const routeName = '/pantry';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PantryBloc, PantryState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Pantry',
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: state is PantryFetched ? _getProducts(state.products) : LoadingView(text: 'Loading pantry...'),
          ),
          floatingActionButton: state is PantryFetched ? _getAddButton(context, state.products) : null,
        );
      },
    );
  }

  Widget _getProducts(List<ExtendedIngredient> products) {
    return ListView(
                children: products
                    .map(
                      (product) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IngredientListTile(imageUrl: product.product.imageUrl, name: product.product.name),
                          Divider(),
                        ],
                      ),
                    )
                    .toList(),
              );
  }

  FloatingActionButton _getAddButton(context, List<ExtendedIngredient> products) => FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ProductSearchBloc>(context).add(FetchProducts(excludedIds: products.map((product) => product.product.id).toList()));
          showFullscreenDialog(
            context: context,
            child: AddProductForm(),
            title: 'Add a product to your pantry!',
            closeButton: _getCloseAddProductFormButton(context),
          );
        },
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
