part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];
}

class FiltersInitial extends FiltersState {
  @override
  List<Object> get props => [];
}

class FiltersLoading extends FiltersState {
  @override
  List<Object> get props => [];
}

class FiltersSaved extends FiltersState {
  final SortBy sortBy;
  final RecipeListFilters filters;

  FiltersSaved({@required this.sortBy, @required this.filters});

  @override
  List<Object> get props => [sortBy, filters];
}
