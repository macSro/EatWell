import 'package:auto_size_text/auto_size_text.dart';
import 'package:eat_well_v1/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../tools.dart';
import '../ingredient_list_tile.dart';

class AddProductForm extends StatefulWidget {
  final bool includeAmount;

  AddProductForm({this.includeAmount = false});

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  String _selectedId;
  String _selectedName;
  String _selectedUnit = 'g';
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) => state is ProductsFound
          ? _selectedId == null || !widget.includeAmount
              ? Column(
                  children: [
                    _getSearchField(),
                    const SizedBox(height: 8),
                    _getSearchButton(state.allProducts),
                    const SizedBox(height: 16),
                    const Divider(),
                    if (state.foundProducts.length > 0) _getSearchResults(state.foundProducts),
                    if (state.foundProducts.length > 0) const Divider(),
                    if (state.foundProducts.length <= 0) _getMissingReport(),
                  ],
                )
              : Column(
                  children: [
                    _getSelectedProductName(context),
                    const SizedBox(height: 16),
                    _getAmountAndExpDateFields(),
                    const SizedBox(height: 16),
                    _getAddButton(),
                  ],
                )
          : LoadingView(text: 'Loading products...'),
    );
  }

  Widget _getSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded),
        hintText: 'Search for a product',
      ),
    );
  }

  Widget _getSearchButton(List<Product> allProducts) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      color: kPrimaryColorDark,
      onPressed: () {
        FocusScope.of(context).unfocus();
        BlocProvider.of<InquiryBloc>(context).add(ResetMissingReportResult());
        BlocProvider.of<ProductSearchBloc>(context).add(
          SearchForProduct(
            allProducts: allProducts,
            searchPhrase: _searchController.text,
          ),
        );
      },
      child: Text(
        'Search',
        style: TextStyle().copyWith(fontSize: 18),
      ),
    );
  }

  Widget _getSearchResults(List<Product> foundProducts) {
    return Expanded(
      child: ListView.builder(
        itemCount: foundProducts.length,
        itemBuilder: (BuildContext context, int index) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IngredientListTile(
              name: foundProducts[index].name,
              imageUrl: foundProducts[index].imageUrl,
              otherTrailing: RaisedButton(
                onPressed: () {
                  if (widget.includeAmount) {
                    setState(() {
                      _selectedId = foundProducts[index].id;
                      _selectedName = foundProducts[index].name;
                    });
                  } else {
                    setState(() {
                      _selectedId = foundProducts[index].id;
                    });
                    Navigator.pop(context, [_selectedId]);
                  }
                },
                child: Text('Select'),
                color: kAccentColor,
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _getSelectedProductName(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selected:',
          style: Theme.of(context).textTheme.headline6,
        ),
        AutoSizeText(
          Tools.capitalizeFirstWord(_selectedName),
          minFontSize: 18,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
        ),
        IconButton(
          splashRadius: 22,
          icon: Icon(
            Icons.clear_rounded,
            color: Colors.redAccent,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _selectedId = null;
              _selectedName = null;
              _selectedUnit = 'g';
            });
          },
        ),
      ],
    );
  }

  Widget _getAmountAndExpDateFields() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    validator: (val) => val.isEmpty
                        ? 'Enter the amount.'
                        : double.tryParse(val) == null
                            ? 'Incorrect value.'
                            : null,
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: 'Amount',
                      contentPadding: const EdgeInsets.only(left: 12, right: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 12, right: 6),
                    ),
                    icon: Icon(Icons.arrow_downward_rounded, size: 20),
                    value: _selectedUnit,
                    items: ['g', 'oz', 'serving', 'clove']
                        .map(
                          (String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RaisedButton(
              child: Text(
                'Select expiry date',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(DateTime.now().year + 100),
                ).then((selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                });
              },
              color: kAccentColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            if (_selectedDate != null) const SizedBox(height: 16),
            if (_selectedDate != null)
              Text(
                'Expiry date selected: ${Tools.getDate(_selectedDate)}',
                style: Theme.of(context).textTheme.headline6,
              ),
          ],
        ),
      ),
    );
  }

  Widget _getAddButton() {
    return RaisedButton(
      color: kPrimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Navigator.pop(
            context,
            [
              _selectedId,
              double.parse(_amountController.text),
              _selectedUnit,
              _selectedDate,
            ],
          );
        }
      },
      child: IconText(
        text: Text(
          'Add',
          style: TextStyle(fontSize: 24),
        ),
        icon: Icon(
          Icons.kitchen_rounded,
          size: 24,
        ),
        squeeze: true,
      ),
    );
  }

  Widget _getMissingReport() {
    return Expanded(
      child: BlocBuilder<InquiryBloc, InquiryState>(
        builder: (context, state) {
          return state is InquiryInitial
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops, no results!',
                      style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Please check the search phrase or report a missing product. We will update the product list!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: 32),
                    RaisedButton(
                      color: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {
                        BlocProvider.of<InquiryBloc>(context).add(
                          ReportMissingProduct(productName: _searchController.text),
                        );
                      },
                      child: IconText(
                        text: Text(
                          'Report!',
                          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
                        ),
                        icon: Icon(Icons.warning_rounded),
                        squeeze: true,
                      ),
                    ),
                  ],
                )
              : state is MissingProductReported
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.outgoing_mail,
                          color: kPrimaryColor,
                          size: 100,
                        ),
                        Text(
                          'Your report has been submitted. Thanks!',
                          style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : LoadingView(
                      text: 'Reporting...',
                    );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
