import 'package:auto_size_text/auto_size_text.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/filters/filters_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../constants.dart';
import '../../screens/all_recipes/all_recipes_screen.dart';
import '../../screens/diet/diet_screen.dart';
import '../../screens/my_recipes/my_recipes_screen.dart';
import '../../screens/pantry/pantry_screen.dart';
import '../drawer/drawer_tile.dart';
import '../icon_text.dart';

class MyDrawer extends StatelessWidget {
  final String userDisplayName;

  MyDrawer({this.userDisplayName = kDefaultUserDisplayName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _getContent(context, userDisplayName),
    );
  }

  Widget _getContent(context, displayName) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      color: kPrimaryColorDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeader(context, displayName),
          const SizedBox(height: 24),
          const Divider(thickness: 2),
          const SizedBox(height: 16),
          MyDrawerTile(
              icon: Icon(
                Icons.fastfood_rounded,
                color: kAccentColor,
              ),
              title: Text('All recipes',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white)),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(RecipesScreen.routeName);
                // BlocProvider.of<RecipeListBloc>(context).add(FetchRecipes());
                BlocProvider.of<FiltersBloc>(context).add(ResetFilters());
              }),
          MyDrawerTile(
            icon: Icon(
              Icons.favorite_border_rounded,
              color: kAccentColor,
            ),
            title: Text('My recipes',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white)),
            onTap: () {
              BlocProvider.of<SavedRecipesBloc>(context)
                  .add(FetchSavedRecipes());
              Navigator.of(context)
                  .pushReplacementNamed(MyRecipesScreen.routeName);
            },
          ),
          MyDrawerTile(
              icon: Icon(
                Icons.kitchen_rounded,
                color: kAccentColor,
              ),
              title: Text(
                'Pantry',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(PantryScreen.routeName);
              }),
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
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DietScreen.routeName);
            },
          ),
          Spacer(),
          Center(child: _getSignOutButton(context)),
        ],
      ),
    );
  }

  ///Sets up the header in the drawer.
  Widget _getHeader(context, displayName) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 56,
            ),
            SizedBox(height: 4),
            Text(
              'EatWell XO',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
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
                '$displayName!',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: kAccentColor),
                minFontSize: 18,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getSignOutButton(context) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<UserBloc>(context).add(SignOut());
      },
      child: IconText(
        squeeze: true,
        icon: Icon(Icons.logout, size: 28),
        text: Text(
          'Sign out',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      textColor: Colors.redAccent,
    );
  }
}
