import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Create a new recipe',
      child: Center(child: const Text('Create a new recipe')),
    );
  }
}
