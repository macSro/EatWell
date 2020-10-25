import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_event.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_state.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:eat_well_v1/widgets/screens/recipe_list/recipe_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          previous is UserLoading && current is UserAuthenticated,
      listener: (context, state) => _navigateToRecipeListScreen(context),
      child: Material(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => state is UserInitial
              ? _getContent(context: context)
              : state is UserRegisteredWithEmail
                  ? _getContent(
                      context: context,
                      emailFill: state.email,
                      passwordFill: state.password)
                  : LoadingView(text: 'Authentication in progress...'),
        ),
      ),
    );
  }

  Widget _getContent({@required context, emailFill, passwordFill}) {
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
                height: 72,
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome to EatWell XO!',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              KeyboardAvoider(
                child: LoginForm(),
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
    );
  }

  _navigateToRecipeListScreen(context) {
    Navigator.of(context).pushReplacementNamed(RecipeListScreen.routeName);
    BlocProvider.of<RecipeListBloc>(context).add(FetchAllRecipes());
  }
}
