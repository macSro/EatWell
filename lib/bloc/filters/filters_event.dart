part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class FetchFilters extends FiltersEvent {
  //?????????????????????
  @override
  List<Object> get props => [];
}

class UpdateFilters extends FiltersEvent {
  final SortBy sortBy;
  final RecipeListFilters filters;

  UpdateFilters({@required this.sortBy, @required this.filters});

  @override
  List<Object> get props => [sortBy, filters];
}
