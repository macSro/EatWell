import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filters.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../tools.dart';
import '../../misc/icon_text.dart';

class FilterList extends StatefulWidget {
  final RecipeListFilters initFilters;

  FilterList({@required this.initFilters});

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final sortIconsData = {
    SortBy.NameAsc: Icons.arrow_upward_rounded,
    SortBy.NameDesc: Icons.arrow_downward_rounded,
    SortBy.PantryProducts: Icons.kitchen_rounded,
    SortBy.Rating: Icons.star_border_rounded,
    SortBy.PreparationTimeAsc: Icons.timer_off_rounded,
    SortBy.PreparationTimeDesc: Icons.timer_rounded,
    SortBy.ServingsAsc: Icons.person_rounded,
    SortBy.ServingsDesc: Icons.group_rounded,
  };
  Map<SortBy, bool> sortBy = {};
  Map<DishType, bool> dishTypeFilters = {};
  Map<Cuisine, bool> cuisineFilters = {};
  Map<Diet, bool> dietFilters = {};

  @override
  void initState() {
    kSortBy.forEach((key, _) => sortBy[key] = key == widget.initFilters.sortBy);
    widget.initFilters.dishTypes.forEach((key, value) => dishTypeFilters[key] = value);
    widget.initFilters.cuisines.forEach((key, value) => cuisineFilters[key] = value);
    widget.initFilters.diets.forEach((key, value) => dietFilters[key] = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              _getSortListTile(widget.initFilters.sortBy),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Filter by',
                  style: Theme.of(context).textTheme.headline4.copyWith(color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 18),
              _getDishTypeListTile(context),
              _getCuisineListTile(context),
              _getDietListTile(context),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _getApplyButton(),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }

  Widget _getApplyButton() {
    return RaisedButton(
      onPressed: () {
        final SortBy selectedSortingOption = sortBy.entries
            .firstWhere(
              (sortingOption) => sortingOption.value == true,
            )
            .key;
        Navigator.pop(context, [selectedSortingOption, dishTypeFilters, cuisineFilters, dietFilters]);
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
    );
  }

  Widget _getSortListTile(SortBy initSort) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ExpansionTile(
        title: IconText(
          text: Text(
            'Sorting options',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
          icon: Icon(
            Icons.sort_rounded,
            color: kPrimaryColorDark,
          ),
          spacing: 16,
        ),
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

  Widget _getDishTypeListTile(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ExpansionTile(
        title: IconText(
          text: Text(
            'Dish types',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
          ),
          icon: Icon(
            Icons.room_service_rounded,
            color: kPrimaryColorDark,
          ),
          spacing: 16,
        ),
        children: dishTypeFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kDishTypes[filter.key]),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                value: filter.value,
                onChanged: (val) {
                  setState(() {
                    dishTypeFilters[filter.key] = val;
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          spacing: 16,
        ),
        children: cuisineFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kCuisines[filter.key]),
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          spacing: 16,
        ),
        children: dietFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kDiets[filter.key]),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                value: filter.value,
                onChanged: (val) {
                  setState(() {
                    dietFilters[filter.key] = val;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
