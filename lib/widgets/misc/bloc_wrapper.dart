import 'package:eat_well_v1/bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import 'package:eat_well_v1/bloc/recipe/recipe_bloc.dart';
import 'package:eat_well_v1/bloc/recipe_list/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWrapper extends StatelessWidget {
  final Widget child;

  const BlocWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: BlocProvider(
        create: (context) => RecipeListBloc(),
        child: BlocProvider(
          create: (context) => RecipeBloc(),
          child: BlocProvider(
            create: (context) => SavedRecipesBloc(),
            child: BlocProvider(
              create: (context) => CreatedRecipesBloc(),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
