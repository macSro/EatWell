part of 'pantry_bloc.dart';

abstract class PantryState extends Equatable {
  const PantryState();

  @override
  List<Object> get props => [];
}

class PantryInitial extends PantryState {
  @override
  List<Object> get props => [];
}

class PantryLoading extends PantryState {
  @override
  List<Object> get props => [];
}

class PantryFetched extends PantryState {
  final List<ExtendedIngredient> products;

  PantryFetched({this.products});

  @override
  List<Object> get props => [];
}
