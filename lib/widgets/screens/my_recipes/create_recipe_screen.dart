import 'package:eat_well_v1/widgets/misc/scaffold.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CreateRecipeScreen extends StatelessWidget {
  static const routeName = '/create-recipe';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      hasAppBar: false,
      title: '',
      hasDrawer: false,
      child: Stack(
        children: [
          ListView(
            children: [
              SizedBox(height: 300),
              Text(
                'Create a new recipe!',
                textAlign: TextAlign.center,
                style: TextStyle().copyWith(fontSize: 28),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(16),
            child: _getBackButton(context),
          ),
        ],
      ),
    );
  }

  Widget _getBackButton(context) {
    return ClipOval(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.65),
              shape: BoxShape.circle,
            ),
            height: 48,
            width: 48,
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
