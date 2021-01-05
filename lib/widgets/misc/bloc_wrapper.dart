import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_v1/bloc/all_recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/diet/diet_bloc.dart';
import 'package:eat_well_v1/bloc/filters/filters_bloc.dart';
import 'package:eat_well_v1/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_v1/bloc/pantry/pantry_bloc.dart';
import 'package:eat_well_v1/bloc/product_search/product_search_bloc.dart';
import 'package:eat_well_v1/repositories/diet_repository.dart';
import 'package:eat_well_v1/repositories/inquiry_repository.dart';
import 'package:eat_well_v1/repositories/pantry_repository.dart';
import 'package:eat_well_v1/repositories/product_search_repository.dart';
import 'package:eat_well_v1/repositories/saved_recipes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/my_recipes/created_recipes/created_recipes_bloc.dart';
import '../../bloc/my_recipes/saved_recipes/saved_recipes_bloc.dart';
import '../../bloc/recipe/recipe_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../repositories/recipe_list_repository.dart';
import '../../repositories/recipe_repository.dart';
import '../../repositories/user_repository.dart';

class FireBlocWrapper extends StatelessWidget {
  final Widget child;

  FireBlocWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserRepository userRepository = UserRepository();
    RecipeRepository recipeRepository = RecipeRepository(
      firestore: firestore,
      userRepository: userRepository,
    );
    PantryRepository pantryRepository =
        PantryRepository(firestore: firestore, userRepository: userRepository);
    RecipeListRepository recipeListRepository = RecipeListRepository(
      firestore: firestore,
      pantryRepository: pantryRepository,
      recipeRepository: recipeRepository,
    );
    SavedRecipesRepository savedRecipesRepository = SavedRecipesRepository(
      firestore: firestore,
      userRepository: userRepository,
      recipeListRepository: recipeListRepository,
    );
    ProductSearchRepository productSearchRepository = ProductSearchRepository(firestore: firestore);
    DietRepository dietRepository = DietRepository(firestore: firestore, userRepository: userRepository);
    InquiryRepository inquiryRepository = InquiryRepository(firestore: firestore);
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
            recipeRepository: recipeRepository,
            userRepository: userRepository,
          ),
        ),
        BlocProvider(
          create: (context) => RecipeBloc(
            recipeRepository: recipeRepository,
          ),
        ),
        BlocProvider(
          create: (context) => SavedRecipesBloc(
            savedRecipesRepository: savedRecipesRepository,
          ),
        ),
        BlocProvider(
          create: (context) => CreatedRecipesBloc(),
        ),
        BlocProvider(
          create: (context) => ProductSearchBloc(
            productSearchRepository: productSearchRepository,
          ),
        ),
        BlocProvider(
          create: (context) => PantryBloc(
            pantryRepository: pantryRepository,
          ),
        ),
        BlocProvider(
          create: (context) => DietBloc(
            dietRepository: dietRepository,
          ),
        ),
        BlocProvider(
          create: (context) => InquiryBloc(
            inquiryRepository: inquiryRepository,
          ),
        ),
        BlocProvider(
          create: (context) => FiltersBloc(),
        ),
      ],
      child: child,
    );
  }
}
