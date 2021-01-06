import 'package:eat_well_v1/bloc/all_recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/diet/diet_bloc.dart';
import 'package:eat_well_v1/bloc/filters/filters_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_event.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import 'package:eat_well_v1/bloc/pantry/pantry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_state.dart';
import '../../../constants.dart';
import '../all_recipes/all_recipes_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) => previous is UserInitial && !(current is UserInitial),
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          //State has to be UserAuthenticated here.
          Navigator.pushReplacementNamed(context, RecipesScreen.routeName);
          _fetchData(context);
        }
      },
      child: Container(
        color: kPrimaryColorDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 200,
            ),
            const SizedBox(height: 32),
            Text(
              'EatWell XO',
              style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.5, 2.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetchData(context) {
    BlocProvider.of<RecipeListBloc>(context).add(FetchRecipes());
    BlocProvider.of<FiltersBloc>(context).add(ResetFilters());
    BlocProvider.of<CreatedRecipesBloc>(context).add(
      FetchCreatedRecipes(),
    );
    BlocProvider.of<SavedRecipesBloc>(context).add(
      FetchSavedRecipes(),
    );
    BlocProvider.of<PantryBloc>(context).add(FetchPantry());
    BlocProvider.of<DietBloc>(context).add(FetchBannedProducts());
  }
}
