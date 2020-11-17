import 'package:cloud_firestore/cloud_firestore.dart';
import '../../bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import '../../bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import '../../bloc/recipe/recipe_bloc.dart';
import '../../bloc/recipes/recipe_list_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../repositories/recipe_list_repository.dart';
import '../../repositories/recipe_repository.dart';
import '../../repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireBlocWrapper extends StatelessWidget {
  final Widget child;

  FireBlocWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserRepository userRepository = UserRepository();
    RecipeListRepository recipeListRepository = RecipeListRepository(
      firestore: firestore,
      userRepository: userRepository,
    );
    RecipeRepository recipeRepository = RecipeRepository(
      firestore: firestore,
      userRepository: userRepository,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            repository: userRepository,
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => RecipeListBloc(
            recipeListRepository: recipeListRepository,
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => RecipeBloc(
            recipeRepository: recipeRepository,
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SavedRecipesBloc(),
        ),
        BlocProvider(
          create: (context) => CreatedRecipesBloc(),
        ),
      ],
      child: child,
    );
  }
}
