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

class FiltersSaved extends FiltersState {
  final RecipeListFilters filters;

  FiltersSaved({@required this.filters});

  @override
  List<Object> get props => [filters];
}
