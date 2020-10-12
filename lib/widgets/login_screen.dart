import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_event.dart';
import 'package:eat_well_v1/constants.dart';
import 'file:///D:/FlutterApps/eat_well_v1/lib/widgets/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'all_recipes/all_recipe_list_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/loginBackground.svg',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/xo.svg',
                  height: 72,
                ),
                const SizedBox(height: 32),
                Text(
                  'Welcome to EatWell XO!',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kPrimaryColorDark),
                ),
                const SizedBox(height: 32),
                KeyboardAvoider(
                  child: _getLoginForm(context),
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                GoogleSignInButton(
                  onPressed: () {},
                  borderRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Sets up the login form.
  final _formKey = GlobalKey<FormState>();
  Widget _getLoginForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Enter your login',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 16),
          RaisedButton(
            onPressed: () => _processLogin(context),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              'Sign In',
              style: TextStyle().copyWith(fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
          RaisedButton(
            onPressed: () => _navigateToRegisterScreen(context),
            color: kPrimaryColor,
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }

  _navigateToRegisterScreen(context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  _processLogin(context) {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacementNamed(AllRecipeListScreen.routeName);
      BlocProvider.of<RecipeBloc>(context).add(FetchAllRecipes());
    }
  }
}
