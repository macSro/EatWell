import 'package:eat_well_v1/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'filter_list.dart';

showRecipeFiltersDialog({
  @required BuildContext context,
}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0.93),
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return _RecipeFiltersDialog();
    },
  );
}

class _RecipeFiltersDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox.expand(
        child: Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'What are you craving?',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: kPrimaryColorDark, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(child: FilterList()),
              ],
            )),
      ),
    );
  }
}

class RecipeListFilters extends Equatable {
  final Map<MealTypes, bool> mealTypes;
  final Map<Cuisines, bool> cuisines;
  final Map<Diets, bool> diets;

  RecipeListFilters({this.mealTypes, this.cuisines, this.diets});

  @override
  List<Object> get props => [mealTypes, cuisines, diets];
}
