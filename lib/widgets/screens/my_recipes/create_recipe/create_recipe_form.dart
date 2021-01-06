import 'dart:io';

import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/product.dart';
import 'package:eat_well_v1/widgets/misc/fullscreen_dialog.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/misc/products/add_product_form.dart';
import 'package:eat_well_v1/widgets/misc/products/edit_product_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import '../../../misc/icon_text.dart';

class CreateRecipeForm extends StatefulWidget {
  final List<ExtendedIngredient> initIngredients;

  CreateRecipeForm({this.initIngredients});

  @override
  _CreateRecipeFormState createState() => _CreateRecipeFormState();
}

class _CreateRecipeFormState extends State<CreateRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  File _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _servingsController = TextEditingController();
  List<ExtendedIngredient> _ingredients = [];

  @override
  void initState() {
    if (widget.initIngredients != null) _ingredients.addAll(widget.initIngredients);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'General',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          _getNameField(),
          const SizedBox(height: 16),
          _getTimeField(),
          const SizedBox(height: 16),
          _getServingsField(),
          const SizedBox(height: 32),
          _getDishTypesButton(),
          const SizedBox(height: 16),
          //TODO: after all of 3 buttons show a list of selected (as Text)
          _getCuisinesButton(),
          const SizedBox(height: 16),
          _getDietsButton(),
          const SizedBox(height: 64),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          _getIngredientList(_ingredients),
          if (_ingredients.isNotEmpty) const SizedBox(height: 16),
          _getAddIngredientButton(),
          const SizedBox(height: 64),
          Text(
            'Instructions',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 64),
          Text(
            'Image',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          _getImagePicker(),
          const SizedBox(height: 12),
          _image == null
              ? Text(
                  'No image selected.',
                  style: Theme.of(context).textTheme.subtitle1,
                )
              : _getImagePlaceholder(),
          const SizedBox(height: 64),
          _getCreateButton(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _getNameField() {
    return TextFormField(
      controller: _nameController,
      minLines: 1,
      maxLines: 5,
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: const Icon(Icons.title_rounded),
        labelText: 'What are you making?',
      ),
    );
  }

  Widget _getTimeField() {
    return TextFormField(
      controller: _timeController,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: const Icon(Icons.timer_rounded),
        labelText: 'How many minutes?',
      ),
    );
  }

  Widget _getServingsField() {
    return TextFormField(
      controller: _servingsController,
      validator: (val) => val.isEmpty
          ? 'Please enter number of servings.'
          : int.tryParse(val) == null
              ? 'Please enter a number.'
              : int.parse(val) <= 0
                  ? 'Please enter a number greater than 0.'
                  : null,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.headline6,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        prefixIcon: const Icon(Icons.group_rounded),
        labelText: 'How many servings?',
      ),
    );
  }

  Widget _getAddIngredientButton() {
    return FloatingActionButton(
      elevation: 3,
      child: Icon(Icons.add_rounded),
      onPressed: () {
        BlocProvider.of<ProductSearchBloc>(context).add(
          FetchProducts(
            excludedIds: _ingredients.map((product) => product.product.id).toList(),
          ),
        );
        showFullscreenDialog(
          context: context,
          child: AddProductForm(includeAmount: true),
          title: 'Select an ingredient!',
        ).then((result) {
          if (result != null) {
            setState(() {
              _ingredients.add(
                ExtendedIngredient(
                  product: result[0],
                  amount: result[1],
                  unit: result[2],
                ),
              );
            });
            // BlocProvider.of<PantryBloc>(context).add(
            //   AddProductToPantry(
            //     currentProducts: products,
            //     productId: result[0],
            //     amount: result[1],
            //     unit: result[2],
            //     expDate: result[3],
            //   ),
            // );
          }
        });
      },
    );
  }

  Widget _getIngredientList(List<ExtendedIngredient> ingredients) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        child: Column(
          children: ingredients
              .map(
                (ingredient) => Column(
                  children: [
                    IngredientListTile(
                      imageUrl: ingredient.product.imageUrl,
                      name: ingredient.product.name,
                      amount: ingredient.amount,
                      unit: ingredient.unit,
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
                                initAmount: ingredient.amount,
                                initUnit: ingredient.unit,
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ).then((result) {
                          if (result != null) {
                            // BlocProvider.of<PantryBloc>(context).add(
                            //   UpdateProductInPantry(
                            //     currentProducts: products,
                            //     productId: products[index].product.id,
                            //     amount: result[0],
                            //     unit: result[1],
                            //     expDate: result[2],
                            //   ),
                            // );
                          }
                        });
                      },
                      onDelete: () {
                        setState(() {
                          _ingredients.removeWhere((ing) => ing.product.name == ingredient.product.name);
                        });
                      },
                    ),
                    ingredient != ingredients.last
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: const Divider(),
                          )
                        : const SizedBox(),
                  ],
                ),
              )
              .toList(),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImagePicker() {
    return RaisedButton(
      onPressed: () async {
        final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      },
      color: kPrimaryColor,
      child: IconText(
        text: Text(
          'Pick an image',
          style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
        ),
        icon: Icon(Icons.photo_rounded),
        squeeze: true,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
    );
  }

  Widget _getImagePlaceholder() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColorLight,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(19),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(_image),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.delete_rounded,
              size: 28,
              color: Colors.redAccent,
            ),
            onPressed: () {
              setState(() {
                _image = null;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getDishTypesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        onPressed: () {},
        color: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconText(
          center: true,
          icon: Icon(Icons.room_service_rounded),
          text: Text(
            'Select dish types',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getCuisinesButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        onPressed: () {},
        color: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconText(
          center: true,
          icon: Icon(Icons.restaurant_rounded),
          text: Text(
            'Select cuisines',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getDietsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        onPressed: () {},
        color: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconText(
          center: true,
          icon: Icon(Icons.block_rounded),
          text: Text(
            'Select diets',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getCreateButton(context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
      color: kAccentColor,
      child: IconText(
        text: Text(
          'Create!',
          style: TextStyle(fontSize: 24),
        ),
        icon: Icon(Icons.check_rounded, size: 30),
        squeeze: true,
      ),
      onPressed: () {},
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _servingsController.dispose();
    super.dispose();
  }
}
