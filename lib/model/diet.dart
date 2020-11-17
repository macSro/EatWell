import 'package:equatable/equatable.dart';

import '../constants.dart';
import 'product.dart';

class Diet extends Equatable {
  final Map<Diets, bool> diets;
  final List<Product> bannedProducts;

  Diet({this.diets, this.bannedProducts});

  @override
  List<Object> get props => [diets, bannedProducts];

  @override
  bool get stringify => true;
}
