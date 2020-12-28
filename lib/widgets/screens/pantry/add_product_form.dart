import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/pantry/pantry_bloc.dart';
import '../../../constants.dart';
import '../../misc/ingredient_list_tile.dart';

class AddProductForm extends StatefulWidget {

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) => state is ProductsFound
          ? Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded),
                    hintText: 'Search for a product',
                  ),
                ),
                const SizedBox(height: 8),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  color: kPrimaryColorDark,
                  onPressed: () {
                    print('controller text: ${_controller.text}');
                    BlocProvider.of<ProductSearchBloc>(context).add(
                        SearchForProduct(allProducts: state.allProducts, searchPhrase: _controller.text));
                  },
                  child: Text(
                    'Search',
                    style: TextStyle().copyWith(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                //TODO: wrap with blocbuilder and show/hide based on results.length
                Expanded(
                  child: ListView.builder(
                    itemCount: state.foundProducts.length,
                    itemBuilder: (BuildContext context, int index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IngredientListTile(
                          name: state.foundProducts[index].name,
                          imageUrl: state.foundProducts[index].imageUrl,
                          otherTrailing: RaisedButton(
                            onPressed: () {
                              //THIS WILL COME FROM BLOCBUILDER
                              BlocProvider.of<PantryBloc>(context)
                                  .add(AddProductToPantry(productId: state.foundProducts[index].id));
                              Navigator.pop(context);
                            },
                            child: Text('Select'),
                            color: kAccentColor,
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Oops, no results!',
                //         style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                //       ),
                //       const SizedBox(height: 32),
                //       Text(
                //         'Please check the search phrase or report a missing product. We will update the product list ASAP.',
                //         textAlign: TextAlign.center,
                //         style: Theme.of(context).textTheme.subtitle1,
                //       ),
                //       const SizedBox(height: 32),
                //       RaisedButton(
                //         color: Colors.redAccent,
                //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //         onPressed: () {},
                //         child: IconText(
                //           text: Text(
                //             'Report!',
                //             style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                //           ),
                //           icon: Icon(Icons.warning_rounded),
                //           squeeze: true,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 16),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Container(
                //       width: 120,
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           hintText: 'Amount',
                //           contentPadding: const EdgeInsets.only(left: 12, right: 12),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 16),
                //     SizedBox(
                //       width: 120,
                //       child: DropdownButtonFormField(
                //         decoration: InputDecoration(
                //           contentPadding: const EdgeInsets.only(left: 12, right: 6),
                //         ),
                //         icon: Icon(Icons.arrow_downward_rounded, size: 20),
                //         value: 'g',
                //         items: ['g', 'oz', 'serving', 'clove']
                //             .map(
                //               (String value) => DropdownMenuItem(
                //                 value: value,
                //                 child: Text(value),
                //               ),
                //             )
                //             .toList(),
                //         onChanged: (value) {},
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // RaisedButton(
                //   color: kPrimaryColor,
                //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                //   onPressed: () {},
                //   child: IconText(
                //     text: Text(
                //       'Add',
                //       style: TextStyle().copyWith(fontSize: 28),
                //     ),
                //     icon: Icon(
                //       Icons.kitchen_rounded,
                //       size: 28,
                //     ),
                //     squeeze: true,
                //   ),
                // ),
                const SizedBox(height: 16),
                //Spacer(),
                const Divider(),
              ],
            )
          : LoadingView(text: 'Loading products...'),
    );
  }
}
