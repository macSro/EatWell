import 'package:eat_well_v1/bloc/all_recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_state.dart';
import 'package:eat_well_v1/bloc/filters/filters_bloc.dart';
import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recipe/recipe_bloc.dart';
import '../../../bloc/recipe/recipe_event.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_state.dart';
import '../../../constants.dart';
import '../../../model/recipe.dart';
import '../../misc/fullscreen_dialog.dart';
import '../../misc/loading.dart';
import '../../misc/scaffold.dart';
import '../filters/filter_list.dart';
import '../recipe/recipe_screen.dart';
import 'recipe_list_item.dart';

class RecipesScreen extends StatelessWidget {
  static const routeName = '/recipes';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeListBloc, RecipeListState>(
      builder: (context, state) {
        return MyScaffold(
          title: 'All recipes',
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  BlocProvider.of<RecipeListBloc>(context).add(FetchRecipes());
                  BlocProvider.of<FiltersBloc>(context).add(ResetFilters());
                }),
          ],
          child: state is RecipesFetched
              ? BlocListener<FiltersBloc, FiltersState>(
                  listener: (context, filtersState) {
                    if (filtersState is FiltersSaved) {
                      BlocProvider.of<RecipeListBloc>(context).add(
                        FilterAndSortRecipes(
                          allRecipes: state.allRecipes,
                          filteredRecipes: state.filteredRecipes,
                          filters: filtersState.filters,
                        ),
                      );
                    }
                  },
                  child: _getContent(context, state.filteredRecipes),
                )
              : LoadingView(text: 'Loading recipes...'),
          floatingActionButton: state is RecipesFetched
              ? FloatingActionButton(
                  onPressed: () {
                    showFullscreenDialog(
                      context: context,
                      child: BlocBuilder<FiltersBloc, FiltersState>(
                        builder: (context, state) => state is FiltersSaved
                            ? FilterList(
                                initFilters: state.filters,
                              )
                            : LoadingView(text: 'Loading filters...'),
                      ),
                      title: 'What are you craving?',
                    ).then(
                      (result) {
                        if (result != null) _applySortByAndFilters(context, state.filteredRecipes, result);
                      },
                    );
                  },
                  child: Icon(Icons.filter_alt_rounded),
                )
              : null,
        );
      },
    );
  }

  _applySortByAndFilters(context, recipes, result) {
    final SortBy sortBy = result[0];
    final Map<DishType, bool> dishTypes = result[1];
    final Map<Cuisine, bool> cuisines = result[2];
    final Map<Diet, bool> diets = result[3];

    BlocProvider.of<FiltersBloc>(context).add(
      UpdateFilters(
        filters: RecipeListFilters(sortBy: sortBy, dishTypes: dishTypes, cuisines: cuisines, diets: diets),
      ),
    );
  }

  Widget _getContent(context, recipes) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => ListView(
        children: state is UserAuthenticated ? _mapRecipesToRecipeItems(context, recipes) : [],
      ),
    );
  }

  _mapRecipesToRecipeItems(context, List<Recipe> recipes) {
    return recipes
        .map((recipe) => RecipeListItem(
              recipe: recipe,
              onTap: () => _navigateToRecipeScreen(context, recipe),
            ))
        .toList();
  }

  _navigateToRecipeScreen(context, recipe) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context).add(
      SelectRecipe(recipe: recipe),
    );
  }
}
