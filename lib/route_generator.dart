import 'package:eat_well_v1/widgets/screens/diet_screen.dart';
import 'package:eat_well_v1/widgets/screens/fridge_screen.dart';
import 'package:eat_well_v1/widgets/screens/login/login_screen.dart';
import 'package:eat_well_v1/widgets/screens/my_recipes/create_recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/my_recipes/my_recipes_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipe/recipe_screen.dart';
import 'package:eat_well_v1/widgets/screens/recipes/recipes_screen.dart';
import 'package:eat_well_v1/widgets/screens/register/register_screen.dart';
import 'package:eat_well_v1/widgets/screens/settings/settings_screen.dart';
import 'package:eat_well_v1/widgets/screens/shopping_list_screen.dart';
import 'package:eat_well_v1/widgets/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget _ScreenBuilder(BuildContext context);

final Map<String, _ScreenBuilder> _routeBuilders = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  RecipesScreen.routeName: (context) => RecipesScreen(),
  RecipeScreen.routeName: (context) => RecipeScreen(),
  MyRecipesScreen.routeName: (context) => MyRecipesScreen(),
  CreateRecipeScreen.routeName: (context) => CreateRecipeScreen(),
  DietScreen.routeName: (context) => DietScreen(),
  FridgeScreen.routeName: (context) => FridgeScreen(),
  ShoppingListScreen.routeName: (context) => ShoppingListScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
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
