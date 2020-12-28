import 'package:flutter/material.dart';

class RecipeList extends StatelessWidget {
  final List<Widget> recipeItems;
  RecipeList({@required this.recipeItems});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recipeItems,
    );
  }
}
