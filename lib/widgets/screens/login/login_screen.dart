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
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../bloc/user/user_state.dart';
import '../../../constants.dart';
import '../../misc/loading.dart';
import '../all_recipes/all_recipes_screen.dart';
import '../error/error_screen.dart';
import '../register/register_screen.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) => previous is UserLoading && current is UserAuthenticated,
        listener: (context, state) => _navigateToRecipeListScreen(context),
        child: BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) => previous is UserLoading && current is UserAuthenticationFailed,
          listener: (context, state) => Navigator.pushNamed(
            context,
            ErrorScreen.routeName,
            arguments: kUserAuthenticationFailedMessage,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state is UserLoading
                ? LoadingView(text: 'Authentication in progress...')
                : _getContent(context),
          ),
        ),
      ),
    );
  }

  Widget _getContent(context) {
    return Stack(
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
                height: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to EatWell XO!',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              KeyboardAvoider(
                child: LoginForm(),
              ),
              const SizedBox(height: 8),
              RaisedButton(
                onPressed: () => _navigateToRegisterScreen(context),
                color: kPrimaryColorDark,
                child: Text(
                  'Sign Up',
                  style: TextStyle().copyWith(fontSize: 18),
                ),
              ),
              const Divider(height: 32),
              GoogleSignInButton(
                onPressed: () => BlocProvider.of<UserBloc>(context).add(SignInWithGoogle()),
                borderRadius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _navigateToRegisterScreen(context) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  _navigateToRecipeListScreen(context) {
    Navigator.of(context).pushReplacementNamed(RecipesScreen.routeName);
    _fetchData(context);
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
