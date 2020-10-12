import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/all_recipes/recipe_list_item.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final Function onItemTap;

  RecipeList({@required this.recipes, @required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: recipes
          .map((recipe) => RecipeListItem(
                id: recipe.id,
                name: recipe.name,
                imageUrl: recipe.imageUrl,
                readyInMinutes: recipe.readyInMinutes,
                servings: recipe.servings,
                rating: recipe.rating,
                onTap: onItemTap,
              ))
          .toList(),
    );
  }
}
