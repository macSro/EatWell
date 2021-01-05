import 'package:eat_well_v1/bloc/filters/filters_bloc.dart';
import 'package:eat_well_v1/widgets/misc/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../tools.dart';
import '../../misc/icon_text.dart';

class FilterList extends StatefulWidget {
  @override
  _FilterListState createState() => _FilterListState();
}

//TODO: NEEDS A SEPARATE BLOC TO REMEMBER FILTERS WHEN USER USES THEM AND OPENS DIALOG AGAIN WITHOUT LEAVING THE SCREEN
class _FilterListState extends State<FilterList> {
  final sortIconsData = {
    SortBy.AZ: Icons.arrow_upward_rounded,
    SortBy.ZA: Icons.arrow_downward_rounded,
    SortBy.Rating: Icons.star_border_rounded,
    SortBy.PreparationTime: Icons.timer_rounded,
    SortBy.Servings: Icons.group_rounded,
    SortBy.PantryProducts: Icons.kitchen_rounded,
  };
  Map<SortBy, bool> sortBy = {};
  Map<String, bool> mealTypesFilters = {};
  Map<String, bool> cuisineFilters = {};
  Map<String, bool> dietsFilters = {};

  @override
  void initState() {
    kMealTypes.forEach((_, value) => mealTypesFilters[value] = false);
    kCuisines.forEach((_, value) => cuisineFilters[value] = false);
    kDiets.forEach((_, value) => dietsFilters[value] = false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (context, state) => state is FiltersInitial
          ? _getContent(initSort: SortBy.AZ)
          : state is FiltersSaved
              ? _getContent(initSort: state.sortBy)
              : LoadingView(
                  text: 'Loading filters...',
                ),
    );
  }

  Widget _getContent({SortBy initSort}) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Sort by',
                  style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 18),
              _getSorting(),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Filter by',
                  style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 18),
              _getMealTypeListTile(context),
              _getCuisineListTile(context),
              _getDietListTile(context),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RaisedButton(
          onPressed: () {
            final SortBy selectedSortingOption = sortBy.entries
                .firstWhere(
                  (sortingOption) => sortingOption.value == true,
                )
                .key;
            print('selected: ${kSortBy[selectedSortingOption]}');
            //TODO: here return filters and in fab inside recipelist screen add event to bloc to sort and to save filters inside bloc and also in drawer and splashscreen i need to reset filters when entering
            Navigator.pop(context, [selectedSortingOption]);
          },
          color: kAccentColor,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Apply',
                style: TextStyle().copyWith(fontSize: 24),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _getSorting(SortBy initSort) {
    kSortBy.forEach((key, _) => sortBy[key] = key == initSort);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: sortBy.entries
            .map(
              (sortingOption) => SwitchListTile(
                title: Text(
                  kSortBy[sortingOption.key],
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                secondary: Icon(
                  sortIconsData[sortingOption.key],
                  color: kPrimaryColorDark,
                ),
                value: sortingOption.value,
                onChanged: (val) {
                  setState(() {
                    if (val) sortBy[sortingOption.key] = val;
                    sortBy.entries.forEach((element) {
                      if (element.key != sortingOption.key) {
                        sortBy[element.key] = false;
                      }
                    });
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _getMealTypeListTile(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ExpansionTile(
        title: IconText(
          text: Text(
            'Meal types',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
          icon: Icon(
            Icons.room_service_rounded,
            color: kPrimaryColorDark,
          ),
          spacing: 32,
        ),
        children: mealTypesFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(filter.key),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
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
      ),
    );
  }

  Widget _getCuisineListTile(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ExpansionTile(
        title: IconText(
          text: Text(
            'Cuisine',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
          icon: Icon(
            Icons.restaurant_rounded,
            color: kPrimaryColorDark,
          ),
          spacing: 32,
        ),
        children: cuisineFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(filter.key),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
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
      ),
    );
  }

  Widget _getDietListTile(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ExpansionTile(
        title: IconText(
          text: Text(
            'Diet',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
          icon: Icon(
            Icons.block_rounded,
            color: kPrimaryColorDark,
          ),
          spacing: 32,
        ),
        children: dietsFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(filter.key),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
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
      ),
    );
  }
}
