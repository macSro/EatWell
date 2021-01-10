import 'package:eat_well_v1/bloc/pantry/pantry_bloc.dart';
import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/products/add_product_form.dart';
import 'package:eat_well_v1/widgets/misc/products/edit_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../misc/fullscreen_dialog.dart';
import '../../misc/scaffold.dart';

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
            child: state is PantryFetched
                ? state.products.isNotEmpty
                    ? _getContent(context, state.products)
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'You haven\'t added any products yet!',
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                : LoadingView(text: 'Loading pantry...'),
          ),
          floatingActionButton: state is PantryFetched ? _getAddButton(context, state.products) : null,
        );
      },
    );
  }

  Widget _getContent(context, List<ExtendedIngredient> products) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text(
                    'Edit details',
                    style: Theme.of(context).textTheme.headline6.copyWith(color: kPrimaryColorDark),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  children: [
                    EditProductForm(
                      initAmount: products[index].amount,
                      initUnit: products[index].unit,
                      initDate: products[index].expDate,
                      withDate: true,
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ).then((result) {
                if (result != null) {
                  if (result[0] == 'remove') {
                    BlocProvider.of<PantryBloc>(context).add(
                      RemoveProductFromPantry(
                        currentProducts: products,
                        productId: products[index].product.id,
                      ),
                    );
                  } else {
                    BlocProvider.of<PantryBloc>(context).add(
                      UpdateProductInPantry(
                        currentProducts: products,
                        productId: products[index].product.id,
                        amount: result[0],
                        unit: result[1],
                        expDate: result[2],
                      ),
                    );
                  }
                }
              });
            },
            child: IngredientListTile(
              name: products[index].product.name,
              imageUrl: products[index].product.imageUrl,
              amount: products[index].amount,
              unit: products[index].unit,
              expDate: products[index].expDate,
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _getAddButton(
    context,
    List<ExtendedIngredient> products,
  ) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<ProductSearchBloc>(context).add(
          FetchProducts(
            excludedIds: products.map((product) => product.product.id).toList(),
          ),
        );
        showFullscreenDialog(
          context: context,
          child: AddProductForm(includeAmount: true, includeDate: true),
          title: 'Add a product to your pantry!',
        ).then((result) {
          if (result != null) {
            BlocProvider.of<PantryBloc>(context).add(
              AddProductToPantry(
                currentProducts: products,
                productId: result[0],
                amount: result[1],
                unit: result[2],
                expDate: result[3],
              ),
            );
          }
        });
      },
      child: Icon(Icons.add_rounded),
    );
  }
}
