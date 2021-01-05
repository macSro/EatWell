import 'package:eat_well_v1/bloc/diet/diet_bloc.dart';
import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/widgets/misc/fullscreen_dialog.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/products/add_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../tools.dart';
import '../../misc/scaffold.dart';

class DietScreen extends StatelessWidget {
  static const routeName = '/diet';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DietBloc, DietState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Diet',
          child: state is BannedProductsFetched
              ? state.products.isNotEmpty
                  ? _getContent(context, state.products)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'You haven\'t banned any products yet!',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
              : LoadingView(text: 'Loading banned products...'),
          floatingActionButton:
              state is BannedProductsFetched ? _getAddButton(context, state.products) : null,
        );
      },
    );
  }

  Widget _getContent(context, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Your banned ingredients',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'You will NOT see recipes containing these products.',
              style:
                  Theme.of(context).textTheme.headline6.copyWith(fontStyle: FontStyle.italic, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _getProducts(products),
          ),
        ],
      ),
    );
  }

  Widget _getImage(imageUrl) {
    return Center(
      child: Container(
        height: 64,
        width: 64,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(child: Image.network(imageUrl)),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: kAccentColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _getProducts(List<Product> products) {
    return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
                        title: Text(Tools.capitalizeFirstWord(products[index].name)),
                        contentPadding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _getImage(products[index].imageUrl),
                                  const SizedBox(width: 18),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      BlocProvider.of<DietBloc>(context).add(
                                        RemoveProductFromBanned(
                                          currentProducts: products,
                                          productId: products[index].id,
                                        ),
                                      );
                                    },
                                    color: Colors.redAccent,
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: IconText(
                                      text: Text('Remove'),
                                      icon: Icon(Icons.delete_rounded),
                                      squeeze: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 12),
                              RaisedButton(
                                onPressed: () => Navigator.pop(context),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                                child: Text('Close', style: TextStyle(fontSize: 24)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: _getImage(products[index].imageUrl),
                ),
              ),
            );
  }

  FloatingActionButton _getAddButton(
    context,
    List<Product> products,
  ) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<ProductSearchBloc>(context).add(
          FetchProducts(
            excludedIds: products.map((product) => product.id).toList(),
          ),
        );
        showFullscreenDialog(
          context: context,
          child: AddProductForm(),
          title: 'Ban a product from your diet!',
        ).then((result) {
          if (result != null) {
            BlocProvider.of<DietBloc>(context).add(
              AddProductToBanned(
                currentProducts: products,
                productId: result[0],
              ),
            );
          }
        });
      },
      child: Icon(Icons.add_rounded),
    );
  }
}
