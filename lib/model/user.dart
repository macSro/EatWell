import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'diet.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final Diet diet;

  User({@required this.id, this.displayName, this.diet});

  @override
  List<Object> get props => [id];
}
