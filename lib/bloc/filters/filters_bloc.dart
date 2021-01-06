import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filters.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersInitial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    if (event is UpdateFilters)
      yield* _updateFilters(event.filters);
    else if (event is ResetFilters) yield* _resetFilters();
  }

  Stream<FiltersState> _updateFilters(RecipeListFilters filters) async* {
    yield FiltersSaved(filters: filters);
  }

  Stream<FiltersState> _resetFilters() async* {
    add(
      UpdateFilters(
        filters: RecipeListFilters(
          sortBy: kDefaultSortBy,
          dishTypes: kDefaultDishTypeFilters,
          cuisines: kDefaultCuisineFilters,
          diets: kDefaultDietFilters,
        ),
      ),
    );
  }
}
