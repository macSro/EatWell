import 'package:equatable/equatable.dart';

import 'diet.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final Diet diet;

  User({this.id, this.displayName, this.diet});

  @override
  List<Object> get props => [id];
}
