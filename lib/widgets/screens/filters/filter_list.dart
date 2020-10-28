import 'package:eat_well_v1/bloc/recipes/recipe_list_bloc.dart';
import 'package:eat_well_v1/bloc/recipes/recipe_list_event.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  Map<MealTypes, bool> mealTypesFilters = {};
  Map<Cuisines, bool> cuisineFilters = {};
  Map<Diets, bool> dietsFilters = {};

  @override
  void initState() {
    kMealTypes.forEach((key, _) => mealTypesFilters[key] = false);
    kCuisines.forEach((key, _) => cuisineFilters[key] = false);
    kDiets.forEach((key, _) => dietsFilters[key] = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _getMealTypeListTile(context),
              _getCuisineListTile(context),
              _getDietListTile(context),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _getSaveButton(context),
      ],
    );
  }

  Widget _getSaveButton(context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 16),
      child: RaisedButton(
        onPressed: () {
          BlocProvider.of<RecipeListBloc>(context).add(FetchFilteredRecipes(
              filters: RecipeListFilters(
            mealTypes: mealTypesFilters,
            cuisines: cuisineFilters,
            diets: dietsFilters,
          )));
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
                kMealTypes[filter.key],
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
                kCuisines[filter.key],
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
                kDiets[filter.key],
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
