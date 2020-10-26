import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:flutter/material.dart';

showRecipeSearchDialog({
  @required BuildContext context,
}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.93),
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return _RecipeSearchDialog();
    },
  );
}

class _RecipeSearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 72),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'What are you craving?',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: kPrimaryColorDark,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          _getMealTypeListTile(context),
                          _getCuisineListTile(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 16),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save',
                        style: TextStyle().copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMealTypeListTile(context) {
    return ExpansionTile(
      title: IconText(
        text: Text(
          'Meal types',
          style: Theme.of(context).textTheme.headline6,
        ),
        icon: Icon(
          Icons.room_service_rounded,
          color: kPrimaryColorDark,
        ),
        spacing: 24,
      ),
      children: [
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Main course',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Side dish',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Dessert',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Appetizer',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Salad',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Bread',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Breakfast',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Soup',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Beverage',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Sauce',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Marinade',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Fingerfood',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Snack',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Drink',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Widget _getCuisineListTile(context) {
    return ExpansionTile(
      title: IconText(
        text: Text(
          'Cuisine',
          style: Theme.of(context).textTheme.headline6,
        ),
        icon: Icon(
          Icons.restaurant_rounded,
          color: kPrimaryColorDark,
        ),
        spacing: 24,
      ),
      children: [
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'African',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'American',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'British',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Cajun',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Caribbean',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Chinese',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Eastern European',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'European',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'French',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'German',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SwitchListTile(
          value: true,
          onChanged: (val) {},
          title: Text(
            'Greek',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
