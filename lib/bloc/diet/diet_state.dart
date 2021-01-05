part of 'diet_bloc.dart';

abstract class DietState extends Equatable {
  const DietState();

  @override
  List<Object> get props => [];
}

class DietInitial extends DietState {
  @override
  List<Object> get props => [];
}

class DietLoading extends DietState {
  @override
  List<Object> get props => [];
}

class BannedProductsFetched extends DietState {
  final List<Product> products;

  BannedProductsFetched({@required this.products});

  @override
  List<Object> get props => [products];
}
