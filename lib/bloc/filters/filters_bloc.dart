import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eat_well_v1/constants.dart';
import 'package:eat_well_v1/widgets/screens/filters/recipe_list_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersInitial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    // TODO: implement mapEventToState
  }
}
