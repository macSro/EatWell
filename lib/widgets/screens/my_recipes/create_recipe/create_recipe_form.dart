import 'dart:io';

import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/widgets/misc/fullscreen_dialog.dart';
import 'package:eat_well_v1/widgets/misc/ingredient_list_tile.dart';
import 'package:eat_well_v1/widgets/misc/products/add_product_form.dart';
import 'package:eat_well_v1/widgets/misc/products/edit_product_form.dart';
import 'package:eat_well_v1/widgets/screens/my_recipes/create_recipe/select_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import '../../../../tools.dart';
import '../../../misc/icon_text.dart';

class CreateRecipeForm extends StatefulWidget {
  final List<ExtendedIngredient> initIngredients;
  final List<DishType> initDishTypes;
  final List<Cuisine> initCuisines;
  final List<Diet> initDiets;

  CreateRecipeForm({this.initIngredients, this.initDishTypes, this.initCuisines, this.initDiets});

  @override
  _CreateRecipeFormState createState() => _CreateRecipeFormState();
}

class _CreateRecipeFormState extends State<CreateRecipeForm> {
  final _formKeyMain = GlobalKey<FormState>();
  final _formKeyInstructions = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  File _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _servingsController = TextEditingController();
  TextEditingController _instructionsController = TextEditingController();
  List<DishType> _dishTypes = [];
  List<Cuisine> _cuisines = [];
  List<Diet> _diets = [];
  List<ExtendedIngredient> _ingredients = [];
  List<String> _instructions = [];

  bool _createPressed = false;

  @override
  void initState() {
    if (widget.initIngredients != null) _ingredients.addAll(widget.initIngredients);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyMain,
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
          _getFiltersButton(),
          const SizedBox(height: 16),
          if (_dishTypes.isNotEmpty || _cuisines.isNotEmpty || _diets.isNotEmpty) _getSelectedFiltersText(),
          if (_dishTypes.isEmpty && _cuisines.isEmpty && _diets.isEmpty)
            Text(
              'No filters selected.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          const SizedBox(height: 64),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          if (_ingredients.isEmpty && _createPressed)
            Text(
              'No ingredients selected!',
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.redAccent),
            ),
          if (_ingredients.isNotEmpty) _getIngredientList(),
          if (_ingredients.isNotEmpty || (_ingredients.isEmpty && _createPressed)) const SizedBox(height: 16),
          _getAddIngredientButton(),
          const SizedBox(height: 64),
          Text(
            'Instructions',
            style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 16),
          if (_instructions.isEmpty && _createPressed)
            Text(
              'No instructions written!',
              style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.redAccent),
            ),
          if (_instructions.isNotEmpty) _getInstructions(),
          if (_instructions.isNotEmpty || (_instructions.isEmpty && _createPressed))
            const SizedBox(height: 16),
          _getAddInstructionsButton(),
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
      validator: (val) => val.isEmpty ? 'Enter recipe name.' : null,
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
      validator: (val) => val.isEmpty
          ? 'Enter preparation time.'
          : int.tryParse(val) == null
              ? 'Enter a number.'
              : int.parse(val) <= 0
                  ? 'Enter a number greater than 0.'
                  : null,
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
          ? 'Enter number of servings.'
          : int.tryParse(val) == null
              ? 'Enter a number.'
              : int.parse(val) <= 0
                  ? 'Enter a number greater than 0.'
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

  Widget _getFiltersButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          showFullscreenDialog(
            context: context,
            title: 'Select filters',
            child: SelectFilters(
              initDishTypes: _dishTypes,
              initCuisines: _cuisines,
              initDiets: _diets,
            ),
          ).then((result) {
            if (result != null) {
              setState(() {
                _dishTypes.clear();
                _dishTypes.addAll(result[0]);
                _cuisines.clear();
                _cuisines.addAll(result[1]);
                _diets.clear();
                _diets.addAll(result[2]);
              });
            }
          });
        },
        color: kPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: IconText(
          squeeze: true,
          center: true,
          icon: Icon(Icons.filter_alt_rounded),
          text: Text(
            'Select filters',
            style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getSelectedFiltersText() {
    List<String> dishTypes =
        _dishTypes.map((dishType) => Tools.capitalizeAllWords(kDishTypes[dishType])).toList();
    List<String> cuisines = _cuisines.map((cuisine) => Tools.capitalizeAllWords(kCuisines[cuisine])).toList();
    List<String> diets = _diets.map((diet) => Tools.capitalizeAllWords(kDiets[diet])).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dish types: $dishTypes',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 8),
        Text(
          'Cuisines: $cuisines',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 8),
        Text(
          'Diets: $diets',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }

  Widget _getIngredientList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _ingredients
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
                        builder: (context) => _getEditIngredientDialog(ingredient),
                      ).then((result) {
                        if (result != null) {
                          setState(() {
                            int index = _ingredients.indexOf(ingredient);
                            _ingredients.removeAt(index);
                            _ingredients.insert(
                              index,
                              ExtendedIngredient(
                                product: ingredient.product,
                                amount: result[0],
                                unit: result[1],
                              ),
                            );
                          });
                        }
                      });
                    },
                    onDelete: () {
                      setState(() {
                        _ingredients.removeWhere((ing) => ing.product.name == ingredient.product.name);
                      });
                    },
                  ),
                  ingredient != _ingredients.last
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
    );
  }

  Widget _getEditIngredientDialog(ExtendedIngredient ingredient) {
    return SimpleDialog(
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
    );
  }

  Widget _getAddIngredientButton() {
    return FloatingActionButton(
      heroTag: 'addIngredientFab',
      elevation: 3,
      child: Icon(Icons.add_rounded),
      onPressed: () {
        FocusScope.of(context).unfocus();
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
          }
        });
      },
    );
  }

  Widget _getInstructions() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _instructions.asMap().entries.map((entry) {
                int stepNumber = entry.key + 1;
                String instruction = entry.value;

                return Column(
                  children: [
                    Text(
                      'Step #$stepNumber',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      instruction,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.justify,
                    ),
                    stepNumber != _instructions.length ? const Divider(height: 32) : const SizedBox(),
                  ],
                );
              }).toList(),
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
        ),
      ],
    );
  }

  Widget _getAddInstructionsButton() {
    return FloatingActionButton(
      heroTag: 'addInstructionFab',
      elevation: 3,
      child: Icon(Icons.add_rounded),
      onPressed: () {
        FocusScope.of(context).unfocus();
        showFullscreenDialog(
          context: context,
          title: 'Instruction step',
          child: Form(
            key: _formKeyInstructions,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _instructionsController,
                  validator: (val) => val.isEmpty ? 'Can\'t be empty.' : null,
                  minLines: 1,
                  maxLines: 16,
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    prefixIcon: const Icon(Icons.group_rounded),
                    labelText: 'Enter one instruction step',
                  ),
                ),
                const SizedBox(height: 16),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  onPressed: () {
                    if (_formKeyInstructions.currentState.validate()) {
                      Navigator.pop(context, [_instructionsController.text]);
                    }
                  },
                  child: IconText(
                    text: Text(
                      'Add',
                      style: TextStyle(fontSize: 24),
                    ),
                    icon: Icon(
                      Icons.check_rounded,
                      size: 24,
                    ),
                    squeeze: true,
                  ),
                ),
              ],
            ),
          ),
        ).then((result) {
          if (result != null) {
            setState(() {
              _instructions.add(result[0]);
            });
          }
          _instructionsController.clear();
        });
      },
    );
  }

  Widget _getImagePicker() {
    return RaisedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();
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
      onPressed: () {
        FocusScope.of(context).unfocus();
        setState(() {
          _createPressed = true;
        });
        if (_formKeyMain.currentState.validate() && _ingredients.isNotEmpty && _instructions.isNotEmpty) {
          print('yass');
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Some information is incorrect or missing!"),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    _servingsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }
}
