part of 'filters_bloc.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class ResetFilters extends FiltersEvent {
  @override
  List<Object> get props => [];
}

class UpdateFilters extends FiltersEvent {
  final RecipeListFilters filters;

  UpdateFilters({@required this.filters});

  @override
  List<Object> get props => [filters];
}
