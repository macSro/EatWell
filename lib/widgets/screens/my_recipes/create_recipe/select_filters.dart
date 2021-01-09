import 'package:eat_well_v1/widgets/misc/icon_text.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../tools.dart';

class SelectFilters extends StatefulWidget {
  final List<DishType> initDishTypes;
  final List<Cuisine> initCuisines;
  final List<Diet> initDiets;

  SelectFilters({this.initDishTypes, this.initCuisines, this.initDiets});

  @override
  _SelectFiltersState createState() => _SelectFiltersState();
}

class _SelectFiltersState extends State<SelectFilters> {
  Map<DishType, bool> _dishTypeFilters = {};
  Map<Cuisine, bool> _cuisineFilters = {};
  Map<Diet, bool> _dietFilters = {};

  @override
  void initState() {
    kDishTypes.entries.forEach((entry) {
      _dishTypeFilters[entry.key] =
          widget.initDishTypes != null ? widget.initDishTypes.contains(entry.key) : false;
    });
    kCuisines.entries.forEach((entry) {
      _cuisineFilters[entry.key] =
          widget.initCuisines != null ? widget.initCuisines.contains(entry.key) : false;
    });
    kDiets.entries.forEach((entry) {
      _dietFilters[entry.key] = widget.initDiets != null ? widget.initDiets.contains(entry.key) : false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              _getDishTypeListTile(context),
              _getCuisineListTile(context),
              _getDietListTile(context),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _getSelectButton(),
        const SizedBox(height: 16),
        const Divider(),
      ],
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
        children: _dishTypeFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kDishTypes[filter.key]),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                value: filter.value,
                onChanged: (val) {
                  setState(() {
                    _dishTypeFilters[filter.key] = val;
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
        children: _cuisineFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kCuisines[filter.key]),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                value: filter.value,
                onChanged: (val) {
                  setState(() {
                    _cuisineFilters[filter.key] = val;
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
        children: _dietFilters.entries
            .map(
              (filter) => SwitchListTile(
                title: Text(
                  Tools.capitalizeAllWords(kDiets[filter.key]),
                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
                ),
                value: filter.value,
                onChanged: (val) {
                  setState(() {
                    _dietFilters[filter.key] = val;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _getSelectButton() {
    return RaisedButton(
      color: kAccentColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      onPressed: () {
        List<DishType> dishTypes =
            _dishTypeFilters.entries.map((entry) => entry.value ? entry.key : null).toList();
        dishTypes.removeWhere((element) => element == null);
        List<Cuisine> cuisines =
            _cuisineFilters.entries.map((entry) => entry.value ? entry.key : null).toList();
        cuisines.removeWhere((element) => element == null);
        List<Diet> diets = _dietFilters.entries.map((entry) => entry.value ? entry.key : null).toList();
        diets.removeWhere((element) => element == null);
        Navigator.pop(context, [dishTypes, cuisines, diets]);
      },
      child: IconText(
        text: Text(
          'Select',
          style: TextStyle(fontSize: 24),
        ),
        icon: Icon(
          Icons.check_rounded,
          size: 24,
        ),
        center: true,
      ),
    );
  }
}
