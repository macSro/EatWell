import 'package:eat_well_v1/widgets/screens/login/login_screen.dart';
import 'package:eat_well_v1/widgets/screens/my_recipe_list/my_recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipe_list/recipe_list_screen.dart';
import 'package:eat_well_v1/widgets/screens/register/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'file:///D:/FlutterApps/eat_well_v1/lib/widgets/screens/filters_screen.dart';
import 'file:///D:/FlutterApps/eat_well_v1/lib/widgets/screens/fridge_screen.dart';
import 'file:///D:/FlutterApps/eat_well_v1/lib/widgets/screens/shopping_list_screen.dart';

typedef Widget _ScreenBuilder(BuildContext context);

final Map<String, _ScreenBuilder> _routeBuilders = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  RecipeListScreen.routeName: (context) => RecipeListScreen(),
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
