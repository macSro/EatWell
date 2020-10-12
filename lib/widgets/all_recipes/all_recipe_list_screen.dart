import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_state.dart';
import 'package:eat_well_v1/model/extended_ingredient.dart';
import 'package:eat_well_v1/model/ingredient.dart';
import 'package:eat_well_v1/model/rating.dart';
import 'package:eat_well_v1/model/recipe.dart';
import 'package:eat_well_v1/widgets/all_recipes/recipe_list.dart';
import 'package:eat_well_v1/widgets/misc/loading_screen.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import '../../constants.dart';
import 'file:///D:/FlutterApps/eat_well_v1/lib/widgets/recipe/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRecipeListScreen extends StatelessWidget {
  static const routeName = '/recipe-list';

  //TODO: Osobne bloci dla Recipes i Recipe i jeden State tylko nadpisywac i elo

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        if (state is AllRecipeListScreen)
          return MyScaffold(
            title: 'Recipes',
            child: RecipeList(
              recipes: (state as FetchedAllRecipes).recipes,
              onItemTap: () => _fetchRecipe(context),
            ),
          );
        else
          return LoadingScreen();
      },
    );
  }

  _fetchRecipe(context) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(FetchRecipeInfo(recipeId: 1));
  }
}
