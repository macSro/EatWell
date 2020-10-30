import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Ingredient extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  Ingredient({@required this.id, @required this.name, this.imageUrl});

  @override
  List<Object> get props => [id, name, imageUrl];
}
