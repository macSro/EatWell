import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/screens/diet/diet_screen.dart';
import 'widgets/screens/error/error_screen.dart';
import 'widgets/screens/pantry/pantry_screen.dart';
import 'widgets/screens/login/login_screen.dart';
import 'widgets/screens/my_recipes/create_recipe_screen.dart';
import 'widgets/screens/my_recipes/my_recipes_screen.dart';
import 'widgets/screens/recipe/recipe_screen.dart';
import 'widgets/screens/recipes/recipes_screen.dart';
import 'widgets/screens/register/register_screen.dart';
import 'widgets/screens/shopping_list/shopping_list_screen.dart';
import 'widgets/screens/splash/splash_screen.dart';

typedef Widget _ScreenBuilder(BuildContext context);

final Map<String, _ScreenBuilder> _routeBuilders = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  RecipesScreen.routeName: (context) => RecipesScreen(),
  RecipeScreen.routeName: (context) => RecipeScreen(),
  MyRecipesScreen.routeName: (context) => MyRecipesScreen(),
  CreateRecipeScreen.routeName: (context) => CreateRecipeScreen(),
  PantryScreen.routeName: (context) => PantryScreen(),
  DietScreen.routeName: (context) => DietScreen(),
  ShoppingListScreen.routeName: (context) => ShoppingListScreen(),
};

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (_routeBuilders.containsKey(settings.name)) {
      final routeBuilder = _routeBuilders[settings.name];
      return CupertinoPageRoute(builder: routeBuilder, settings: settings);
    } else if (settings.name == ErrorScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) => settings.arguments != null
              ? ErrorScreen(message: settings.arguments)
              : ErrorScreen(),
          settings: settings);
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
