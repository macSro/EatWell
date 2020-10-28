import 'package:auto_size_text/auto_size_text.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_event.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import 'package:eat_well_v1/bloc/recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipes/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/widgets/misc/authenticated_view.dart';
import 'package:eat_well_v1/widgets/screens/diet_screen.dart';
import 'package:eat_well_v1/widgets/screens/my_recipes/my_recipes_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipes_screen.dart';
import 'package:eat_well_v1/widgets/screens/settings/settings_screen.dart';
import 'package:eat_well_v1/widgets/screens/shopping_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../screens/fridge_screen.dart';
import '../drawer/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => state is UserAuthenticated
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 48,
                ),
                color: kPrimaryColorDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getHeader(context, state.user.displayName ?? 'chef!'),
                    const SizedBox(height: 24),
                    const Divider(thickness: 2),
                    const SizedBox(height: 16),
                    MyDrawerTile(
                        icon: Icon(
                          Icons.fastfood_rounded,
                          color: kAccentColor,
                        ),
                        title: Text('All Recipes',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white)),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(RecipesScreen.routeName);
                          BlocProvider.of<RecipeListBloc>(context)
                              .add(FetchAllRecipes());
                        }),
                    MyDrawerTile(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: kAccentColor,
                      ),
                      title: Text('My Recipes',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(MyRecipesScreen.routeName);
                        BlocProvider.of<CreatedRecipesBloc>(context)
                            .add(FetchCreatedRecipes(userId: state.user.id));
                        BlocProvider.of<SavedRecipesBloc>(context)
                            .add(FetchSavedRecipes(userId: state.user.id));
                      },
                    ),
                    MyDrawerTile(
                      icon: Icon(
                        Icons.block_rounded,
                        color: kAccentColor,
                      ),
                      title: Text('Diet',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(DietScreen.routeName),
                    ),
                    MyDrawerTile(
                      icon: Icon(
                        Icons.kitchen_rounded,
                        color: kAccentColor,
                      ),
                      title: Text('E-Fridge',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(FridgeScreen.routeName),
                    ),
                    MyDrawerTile(
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: kAccentColor,
                      ),
                      title: Text('Shopping list',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white)),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(ShoppingListScreen.routeName),
                    ),
                    MyDrawerTile(
                      icon: Icon(
                        Icons.settings_rounded,
                        color: Colors.grey[400],
                      ),
                      title: Text('Settings',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.grey[400])),
                      onTap: () => Navigator.of(context)
                          .pushReplacementNamed(SettingsScreen.routeName),
                    ),
                  ],
                ),
              )
            : AuthenticatedView(),
      ),
    );
  }

  ///Sets up the header in the drawer.
  Widget _getHeader(context, displayName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(
          'assets/images/logo.svg',
          width: 64,
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello there,',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              AutoSizeText(
                displayName,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: kAccentColor),
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    );
  }
}
