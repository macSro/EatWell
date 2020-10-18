import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_state.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:eat_well_v1/widgets/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/recipe_list/recipe_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeListScreen extends StatelessWidget {
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
          floatingActionButton: state is AllRecipesFetched
              ? FloatingActionButton(
                  onPressed: () {
                    //TODO: move to filters dialog and create a show function like in Cellere
                    showGeneralDialog(
                      context: context,
                      barrierColor: Colors.white.withOpacity(0.93),
                      barrierDismissible: false,
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) {
                        return SizedBox.expand(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 32,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'What are you craving?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: kPrimaryColorDark,
                                          fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 8),
                                  child: Text(
                                    'Close',
                                    style: TextStyle().copyWith(fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
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

  Widget _getContent(context, recipes) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => RecipeList(
        recipes: recipes,
        onItemTap: () {
          if (state is UserAuthenticated)
            _fetchRecipe(context, 1, state.user.id);
        },
      ),
    );
  }

  _fetchRecipe(context, recipeId, userId) {
    Navigator.of(context).pushNamed(RecipeScreen.routeName);
    BlocProvider.of<RecipeBloc>(context)
        .add(FetchRecipeDetails(recipeId: recipeId, userId: userId));
  }
}
