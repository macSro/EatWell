import 'package:flutter/foundation.dart';

class Ingredient {
  final int id;
  final String name;
  final String imageUrl;

  Ingredient({@required this.id, @required this.name, this.imageUrl});
}
