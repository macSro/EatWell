import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  Product({@required this.id, @required this.name, this.imageUrl});

  @override
  List<Object> get props => [id, name, imageUrl];

  @override
  bool get stringify => true;
}
