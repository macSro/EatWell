import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_state.dart';
import 'package:eat_well_v1/widgets/all_recipes/recipe_list.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:eat_well_v1/widgets/recipe/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRecipeListScreen extends StatelessWidget {
  static const routeName = '/recipe-list';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'Recipes',
          child: state is AllRecipesFetched
              ? _getContent(context, state.recipes)
              : LoadingView(text: 'Loading recipes...'),
        );
      },
    );
  }

  Widget _getContent(context, recipes) {
    return RecipeList(
      recipes: recipes,
      onItemTap: () => _fetchRecipe(context),
    );
  }

  _fetchRecipe(context) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(FetchRecipeDetails(recipeId: 1));
  }
}
