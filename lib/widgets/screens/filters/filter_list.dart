import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/recipes/recipe_list_bloc.dart';
import '../../../bloc/recipes/recipe_list_event.dart';
import '../../../constants.dart';
import '../../../tools.dart';
import '../../misc/icon_text.dart';
import 'recipe_list_filter.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  Map<String, bool> mealTypesFilters = {};
  Map<String, bool> cuisineFilters = {};
  Map<String, bool> dietsFilters = {};
  VoidCallback pop;
  //Function(........) onPop;
  //TODO: add pop (default Navigator.pop(context); and onPop for other actions
  @override
  void initState() {
    kMealTypes.forEach((_, value) => mealTypesFilters[value] = false);
    kCuisines.forEach((_, value) => cuisineFilters[value] = false);
    kDiets.forEach((_, value) => dietsFilters[value] = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _getMealTypeListTile(context),
        _getCuisineListTile(context),
        _getDietListTile(context),
      ],
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
      children: mealTypesFilters.entries
          .map(
            (filter) => SwitchListTile(
              title: Text(
                Tools.capitalizeAllWords(filter.key),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: filter.value,
              onChanged: (val) {
                setState(() {
                  mealTypesFilters[filter.key] = val;
                });
              },
            ),
          )
          .toList(),
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
      children: cuisineFilters.entries
          .map(
            (filter) => SwitchListTile(
              title: Text(
                Tools.capitalizeAllWords(filter.key),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: filter.value,
              onChanged: (val) {
                setState(() {
                  cuisineFilters[filter.key] = val;
                });
              },
            ),
          )
          .toList(),
    );
  }

  Widget _getDietListTile(context) {
    return ExpansionTile(
      title: IconText(
        text: Text(
          'Diet',
          style: Theme.of(context).textTheme.headline6,
        ),
        icon: Icon(
          Icons.block_rounded,
          color: kPrimaryColorDark,
        ),
        spacing: 24,
      ),
      children: dietsFilters.entries
          .map(
            (filter) => SwitchListTile(
              title: Text(
                Tools.capitalizeAllWords(filter.key),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: filter.value,
              onChanged: (val) {
                setState(() {
                  dietsFilters[filter.key] = val;
                });
              },
            ),
          )
          .toList(),
    );
  }
}
