import 'package:equatable/equatable.dart';

import 'diet.dart';

class User extends Equatable {
  final int id;
  final String displayName;
  final Diet diet;
  final int points;

  User({this.id, this.displayName, this.diet, this.points});

  @override
  List<Object> get props => [id];
}
