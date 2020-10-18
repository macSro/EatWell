import 'package:eat_well_v1/widgets/all_recipes/recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/filters_screen.dart';
import 'package:eat_well_v1/widgets/fridge_screen.dart';
import 'package:eat_well_v1/widgets/login_screen.dart';
import 'package:eat_well_v1/widgets/my_recipe/my_recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/register/register_screen.dart';
import 'package:eat_well_v1/widgets/shopping_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/recipe/recipe_screen.dart';

typedef Widget _ScreenBuilder(BuildContext context);

final Map<String, _ScreenBuilder> _routeBuilders = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  AllRecipeListScreen.routeName: (context) => AllRecipeListScreen(),
  MyRecipeListScreen.routeName: (context) => MyRecipeListScreen(),
  RecipeScreen.routeName: (context) => RecipeScreen(),
  FiltersScreen.routeName: (context) => FiltersScreen(),
  FridgeScreen.routeName: (context) => FridgeScreen(),
  ShoppingListScreen.routeName: (context) => ShoppingListScreen(),
};

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (_routeBuilders.containsKey(settings.name)) {
      final routeBuilder = _routeBuilders[settings.name];
      return CupertinoPageRoute(builder: routeBuilder, settings: settings);
    } else {
      return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(settings) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text(
              'Wrong route...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}
