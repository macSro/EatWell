import 'package:auto_size_text/auto_size_text.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/widgets/filters_screen.dart';
import 'package:eat_well_v1/widgets/my_recipe/my_recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/recipe_list/recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/shopping_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../fridge_screen.dart';
import '../drawer/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        color: kPrimaryColorDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getHeader(context),
            const SizedBox(height: 24),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            MyDrawerTile(
              iconData: Icons.fastfood_rounded,
              title: 'All Recipes',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(RecipeListScreen.routeName),
            ),
            MyDrawerTile(
              iconData: Icons.favorite_border_rounded,
              title: 'My Recipes',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(MyRecipeListScreen.routeName),
            ),
            MyDrawerTile(
              iconData: Icons.check_circle_outline_rounded,
              title: 'Custom filters',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName),
            ),
            MyDrawerTile(
              iconData: Icons.kitchen_rounded,
              title: 'E-Fridge',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(FridgeScreen.routeName),
            ),
            MyDrawerTile(
              iconData: Icons.shopping_cart_outlined,
              title: 'Shopping list',
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(ShoppingListScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }

  ///Sets up the header in the drawer.
  Widget _getHeader(context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => Row(
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
                  state is UserAuthenticated
                      ? '${state.user.displayName ?? 'chef!'}'
                      : 'chef!',
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
      ),
    );
  }
}
